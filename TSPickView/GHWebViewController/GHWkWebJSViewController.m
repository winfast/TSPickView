//
//  GHWkWebJSViewController.m
//  GHome
//
//  Created by Qincc on 2021/2/3.
//

#import "GHWkWebJSViewController.h"
#import <WebKit/WebKit.h>
#import "GHThirdKey.h"
#import "GHHudTip.h"

@interface GHWkWebJSViewController ()<WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation GHWkWebJSViewController

- (void)dealloc {
	[self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.hbd_barShadowHidden = YES;
	
	[self viewsLayout];
}

- (void)viewsLayout {
	WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
	WKPreferences *preferences = [WKPreferences new];
	preferences.javaScriptCanOpenWindowsAutomatically = YES;
	configuration.preferences = preferences;
	
	self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:GH_CucoMall] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	[self.webView loadRequest:request];
	self.webView.backgroundColor = [UIColor whiteColor];
	self.webView.UIDelegate = self;
	self.webView.navigationDelegate = self;
	self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
	[self.view addSubview:self.webView];
	[self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, KTabbarHeight, 0));
	}];
	
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
	longPress.delegate = self; //记得在.h文件里加上委托
	longPress.minimumPressDuration = 0.4; //这里为什么要设置0.4，因为只要大于0.5就无效，好像大概是因为默认的跳出放大镜的手势的长按时间是0.5秒，
	//如果我们自定义的手势大于或小于0.5秒的话就来不及替换他的默认手势了，这是只是我的猜测。但是最好大于0.2秒，因为有的pdf有一些书签跳转功能，这个值太小的话可能会使这些功能失效。
	[self.webView addGestureRecognizer:longPress];
	
	[self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
	
	self.progressView = UIProgressView.alloc.init;
	self.progressView.trackTintColor = UIColor.clearColor;
	self.progressView.progressTintColor = ASColorHex(0x0BD087);
	[self.view addSubview:self.progressView];
	[self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.webView.mas_top);
		make.left.right.mas_equalTo(0);
		make.height.mas_equalTo(2);
	}];
	
	[GHHudTip showHUDWithMessage:nil inView:self.view];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	NSNumber *progressNumber = change[NSKeyValueChangeNewKey];
	if (progressNumber.floatValue == 1.0) {
		[self.progressView setProgress:1 animated:YES];
		self.progressView.hidden = YES;
	} else {
		[self.progressView setProgress:progressNumber.floatValue animated:YES];
		self.progressView.hidden = NO;
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	// addScriptMessageHandler 很容易导致循环引用
	// 控制器 强引用了WKWebView,WKWebView copy(强引用了）configuration， configuration copy （强引用了）userContentController
	// userContentController 强引用了 self （控制器）
	[self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goLink"];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	// 因此这里要记得移除handlers
	[self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"goLink"];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return NO; //这里一定要return NO,至于为什么大家去看看这个方法的文档吧。
	//还有就是这个委托在你长按的时候会被多次调用，大家可以用nslog输出gestureRecognizer和otherGestureRecognizer
	//看看都是些什么东西。
}

- (void)back {
	if (self.webView.canGoBack) {
		[self.webView goBack];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
	[GHHudTip hideHUDWithView:self.view];
	self.title = self.title ? : webView.title;
	[webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
	[webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{

}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
//    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
	NSLog(@"body:%@",message.body);
	if ([message.name isEqualToString:@"goLink"]) {
		[UIApplication.sharedApplication openURL:[NSURL URLWithString:message.body] options:@{} completionHandler:^(BOOL success) {
			
		}];
	}
}

@end

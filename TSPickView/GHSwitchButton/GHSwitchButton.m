//
//  GHSwitchButton.m
//  GHSwitchButton
//
//  Created by Qincc on 2021/1/6.
//

#import "GHSwitchButton.h"
#import <Masonry/Masonry.h>

@interface GHSwitchButton ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic, strong) UIPanGestureRecognizer *gesture;

@end

@implementation GHSwitchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewsLayout];
    }
    return self;
}

- (void)viewsLayout {
    self.topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.topBtn.tag = 100;
    [self.topBtn addTarget:self action:@selector(clickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.topBtn.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.topBtn];
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(12);
        make.right.mas_equalTo(-12).priority(900);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5).offset(-12).priority(900);
    }];
    
    self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn.backgroundColor = UIColor.whiteColor;
    self.bottomBtn.tag = 101;
    [self.bottomBtn addTarget:self action:@selector(clickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.bottom.right.mas_equalTo(-12).priority(900);
        make.height.mas_equalTo(self.topBtn);
    }];
    
    self.bgView = UIView.alloc.init;
    self.bgView.layer.contents = (id)[UIImage imageNamed:@"control_sw5_button_switch_on"].CGImage;
    self.bgView.layer.contentsScale = [UIImage imageNamed:@"control_sw5_button_switch_on"].scale;
	[self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapAction:)]];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.topBtn);
    }];
    
    self.gesture = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(move:)];
    self.gesture.maximumNumberOfTouches = 1;
    self.gesture.minimumNumberOfTouches = 1;
    [self.bgView addGestureRecognizer:self.gesture];
    
    [self layoutIfNeeded];
}

- (void)move:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:self.bgView];
        self.bgView.center = CGPointMake(self.bgView.center.x, self.bgView.center.y + translation.y);
        if (self.bgView.center.y > self.bottomBtn.center.y) {
            self.bgView.center = self.bottomBtn.center;
        }
        
        if (self.bgView.center.y < self.topBtn.center.y) {
            self.bgView.center = self.topBtn.center;
        }
        [panGestureRecognizer setTranslation:CGPointZero inView:self.bgView];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (CGRectGetMidY(self.bgView.frame) > CGRectGetMidY(self.bounds)) {
            self.bgView.center = self.bottomBtn.center;
            self.bgView.layer.contents = (id)[UIImage imageNamed:@"control_sw5_button_switch_off"].CGImage;
			if ([self.customDelegate respondsToSelector:@selector(delegator:didClickedEvent:info:)]) {
				[self.customDelegate delegator:NSStringFromClass(self.class) didClickedEvent:nil info:@(NO)];
			}
        } else {
            self.bgView.center = self.topBtn.center;
            self.bgView.layer.contents = (id)[UIImage imageNamed:@"control_sw5_button_switch_on"].CGImage;
			if ([self.customDelegate respondsToSelector:@selector(delegator:didClickedEvent:info:)]) {
				[self.customDelegate delegator:NSStringFromClass(self.class) didClickedEvent:nil info:@(YES)];
			}
        }
    }
}

- (void)bgViewTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
	CGRectGetMinY(self.bgView.frame) <= 12 ? [self clickTopBtn:self.bottomBtn] : [self clickTopBtn:self.topBtn];
}

- (void)clickTopBtn:(UIButton *)sender {
	[UIView animateWithDuration:0.15 animations:^{
		self.bgView.center = [sender center];
	} completion:^(BOOL finished) {
		self.bgView.layer.contents = (id)[UIImage imageNamed:[sender tag] == 100 ? @"control_sw5_button_switch_on" : @"control_sw5_button_switch_off"].CGImage;
	}];
		
	if ([self.customDelegate respondsToSelector:@selector(delegator:didClickedEvent:info:)]) {
		[self.customDelegate delegator:NSStringFromClass(self.class) didClickedEvent:sender info:@(sender.tag == 100 ? YES : NO)];
	}
}

- (void)reloadStatus:(BOOL)status {
	UIButton *sender = status ? self.topBtn : self.bottomBtn;
	[UIView animateWithDuration:0.15 animations:^{
		self.bgView.center = [sender center];
	} completion:^(BOOL finished) {
		self.bgView.layer.contents = (id)[UIImage imageNamed:status ? @"control_sw5_button_switch_on" : @"control_sw5_button_switch_off"].CGImage;
	}];
}

@end

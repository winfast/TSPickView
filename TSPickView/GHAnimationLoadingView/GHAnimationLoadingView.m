//
//  AnimationView.m
//  Animation
//
//  Created by Qincc on 2020/12/24.
//

#import "GHAnimationLoadingView.h"

@interface GHAnimationLoadingView ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *cycleLayer;

@end

@implementation GHAnimationLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cycleLayer = CAShapeLayer.layer;
        self.cycleLayer.lineWidth = 2;
        self.cycleLayer.fillColor = UIColor.clearColor.CGColor;
        self.cycleLayer.strokeColor = [UIColor colorWithRed:193/255.0 green:204/255.0 blue:201/255.0 alpha:1].CGColor;
        
        self.cycleLayer.lineCap = kCALineCapRound;
        self.cycleLayer.lineJoin = kCALineJoinRound;
        
        self.cycleLayer.frame = self.bounds;
        self.cycleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        [self.layer addSublayer:self.cycleLayer];
    }
    return self;
}

- (void)startAnimation {
//	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive:)	name:UIApplicationDidBecomeActiveNotification object:nil];
//	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
//	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive:)	name:UIApplicationWillResignActiveNotification object:nil];
	
    [self strokeAnimation];
    [self rotateAnimation];
}

- (void)stopAnimation {
	[self.cycleLayer removeAllAnimations];
}

- (void)setPathColor:(UIColor *)pathColor {
	_pathColor = pathColor;
	self.cycleLayer.strokeColor = pathColor.CGColor;
}

- (void)strokeAnimation {
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeAnimation.fromValue = @(-1);
    strokeAnimation.toValue = @(1);
    strokeAnimation.repeatCount = MAXFLOAT;
    strokeAnimation.removedOnCompletion = YES;
    strokeAnimation.cumulative = YES;
    strokeAnimation.removedOnCompletion = YES;
    strokeAnimation.cumulative = YES;
//    [self.cycleLayer addAnimation:strokeAnimation forKey:@"strokeStartAnimation"];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    strokeEndAnimation.repeatCount = MAXFLOAT;
    strokeEndAnimation.removedOnCompletion = YES;
    strokeEndAnimation.cumulative = YES;
//    [self.cycleLayer addAnimation:strokeEndAnimation forKey:@"strokeStartAnimation"];

    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = 6;
    animationGroup.animations = @[strokeAnimation, strokeEndAnimation];
    animationGroup.duration = 1.5;
	animationGroup.delegate = self;
    [self.cycleLayer addAnimation:animationGroup forKey:@"animationGroup"];
}

- (void)rotateAnimation {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(M_PI * 2);
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 8;
    [self.cycleLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
}

//动画有可能异常中断
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	self.hidden = YES;
}

- (void)setHidden:(BOOL)hidden {
	[super setHidden:hidden];
	if (hidden) {
//		[NSNotificationCenter.defaultCenter removeObserver:self];
		[self.cycleLayer removeAllAnimations];
	}
}

//#pragma mark - notify 当推到后台的时候，暂停动画， 如果进入前台， 启动动画
//- (void)applicationDidBecomeActive:(NSNotification *)note
//{
//	[self resumeAnimate:self.cycleLayer];
//}
//
//- (void)applicationDidEnterBackground:(NSNotification *)note
//{
//	[self pauseAnimation:self.cycleLayer];
//}
//
//- (void)applicationWillResignActive:(NSNotification *)note
//{
//	[self pauseAnimation:self.cycleLayer];
//}
//
//#pragma mark - 恢复动画
//- (void)resumeAnimate:(CALayer *)layer {
//	if (self.isHidden == YES) {
//		return;
//	}
//
//	if (![layer animationForKey:@"rotateAnimation"] || ![layer animationForKey:@"animationGroup"]) {
//		return;
//	}
//
//	CFTimeInterval pausedTime = [layer timeOffset];
//	layer.speed = 1.0;
//	layer.timeOffset = 0.0;
//	layer.beginTime = 0.0;
//	CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
//	layer.beginTime = timeSincePause;
//}
//
//#pragma mark - 暂停动画
//- (void)pauseAnimation:(CALayer *)layer {
//	if (self.isHidden == YES) {
//		return;
//	}
//
//	if (![layer animationForKey:@"rotateAnimation"] || ![layer animationForKey:@"animationGroup"]) {
//		return;
//	}
//
//	CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
//	layer.speed = 0.0;
//	layer.timeOffset = pausedTime;
//}

@end

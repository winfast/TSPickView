//
//  GHProgressButton.m
//  GHome
//
//  Created by Qincc on 2020/12/27.
//

#import "GHProgressButton.h"

@interface GHProgressButton ()

//用户绘制进度的layer
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic) CGSize buttonSize;

@end

@implementation GHProgressButton

+ (instancetype)buttonWithSize:(CGSize)size; {
	GHProgressButton *button = [GHProgressButton buttonWithType:UIButtonTypeCustom];
	button.buttonSize = size;
	button.bounds = CGRectMake(0, 0, size.width, size.height);
	[button.layer addSublayer:button.shapeLayer];
	button.shapeLayer.frame = CGRectMake(0, 0, 0, size.height);
	return button;
}

- (CAShapeLayer *)shapeLayer {
	if (!_shapeLayer) {
		_shapeLayer = CAShapeLayer.layer;
		_shapeLayer.backgroundColor = ASColorHex(0xFFFFFF).CGColor;
		//默认self.shapeLayer是在默认UIButton的中间开始动画，下面两行代码是让layer从左边开始动画
		_shapeLayer.anchorPoint = CGPointMake(0, 0);
		_shapeLayer.position = CGPointMake(0, 0);
	}
	return _shapeLayer;
}

- (void)setProgress:(CGFloat)progress {
	//使用width动画
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
	anim.duration = 1;
	anim.toValue = @(progress *self.buttonSize.width);
	anim.removedOnCompletion = NO;
	//保存动画最前面效果
	anim.fillMode = kCAFillModeForwards;
	[self.shapeLayer addAnimation:anim forKey:nil];
}

@end

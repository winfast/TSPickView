//
//  TSColorLabel.m
//  TSPickView
//
//  Created by Qincc on 2021/1/23.
//  Copyright © 2021 Galanz. All rights reserved.
//

#import "TSColorLabel.h"


@interface TSColorLabel ()

@property (nonatomic, strong) CALayer *progressLayer;

@property (nonatomic, strong) CALayer *showProgressLayer;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation TSColorLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewsLayout];
    }
    return self;
}

- (void)viewsLayout {
    
    //用户可见的进度
    self.showProgressLayer = CALayer.layer;
    self.showProgressLayer.anchorPoint = CGPointMake(0, 0);
    self.showProgressLayer.position = CGPointMake(0, 0);
    self.showProgressLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
    self.showProgressLayer.backgroundColor = UIColor.grayColor.CGColor;
    [self.layer addSublayer:self.showProgressLayer];
    
    self.maskLayer = CALayer.layer;
    self.maskLayer.backgroundColor = UIColor.redColor.CGColor;
    self.maskLayer.frame = self.bounds;
    [self.layer addSublayer:self.maskLayer];
    
    //给maskLayer设置的进度颜色
    self.progressLayer = CALayer.layer;
    self.progressLayer.anchorPoint = CGPointMake(0, 0);
    self.progressLayer.position = CGPointMake(0, 0);
    self.progressLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
    self.progressLayer.backgroundColor = UIColor.blackColor.CGColor;
    [self.maskLayer addSublayer:self.progressLayer];
    
    self.textLabel = [UILabel.alloc initWithFrame:self.bounds];
    self.textLabel.textColor = UIColor.blackColor;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = @"50%";
    [self addSubview:self.textLabel];
    
    self.maskLayer.mask = self.textLabel.layer;
    
    //这一步很重要
    //5. 一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    self.textLabel.frame = self.maskLayer.bounds;
}


- (void)startProgressLayer:(BOOL)direction {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    anim.duration = 3;
    anim.toValue = @(direction ? self.bounds.size.width : 0);
    anim.removedOnCompletion = NO;
    //保存动画最前面效果
    anim.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:anim forKey:nil];
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    anim1.duration = 3;
    anim1.toValue = @(direction ? self.bounds.size.width : 0);
    anim1.removedOnCompletion = NO;
    //保存动画最前面效果
    anim1.fillMode = kCAFillModeForwards;
    [self.showProgressLayer addAnimation:anim1 forKey:nil];
}

@end

//
//  GHViewController.m
//  TSPickView
//
//  Created by Qincc on 2021/1/9.
//  Copyright © 2021 Galanz. All rights reserved.
//  文字变色动画 简单来说 在进度的过程中 有一部分文字浅色，有一部分深色

#import "GHViewController.h"
#import "TSColorLabel.h"

@interface GHViewController ()

@property (nonatomic, strong) CALayer *progressLayer;
@property (nonatomic) BOOL dir;

@property (nonatomic, strong) TSColorLabel *label;

@end

@implementation GHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.label = [TSColorLabel.alloc initWithFrame:CGRectMake(10, 100, 150, 44)];
    self.label.backgroundColor = UIColor.whiteColor;
    self.label.layer.cornerRadius = 22;
    self.label.layer.borderColor = UIColor.redColor.CGColor;
    self.label.layer.masksToBounds = YES;
    self.label.layer.borderWidth = 0.5;
    
    self.label.textLabel.text = @"我的个神呀";
    self.label.maskLayer.backgroundColor = UIColor.blackColor.CGColor;
    self.label.progressLayer.backgroundColor = UIColor.redColor.CGColor;
    self.label.showProgressLayer.backgroundColor = UIColor.yellowColor.CGColor;
    [self.view addSubview:self.label];
    
    return;
    
    
  //   Do any additional setup after loading the view.
    self.dir = NO;
    
    CALayer *maskLayer = CALayer.layer;
    maskLayer.backgroundColor = UIColor.redColor.CGColor;
    maskLayer.frame = CGRectMake(10, 100, 200, 44);
    
    
    self.progressLayer = CALayer.layer;
    self.progressLayer.anchorPoint = CGPointMake(0, 0);
    self.progressLayer.position = CGPointMake(0, 0);
    self.progressLayer.frame = CGRectMake(0, 0, 0, 44);
    self.progressLayer.backgroundColor = UIColor.blackColor.CGColor;
    [maskLayer addSublayer:self.progressLayer];
  
    
//        CAGradientLayer *gradientLayer = CAGradientLayer.layer;
//        gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)UIColor.greenColor.CGColor];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.frame = CGRectMake(10, 100, 200, 44);
    [self.view.layer addSublayer:maskLayer];
    
    
    UIView *bgView = [UIView.alloc initWithFrame:CGRectMake(10, 100, 200, 44)];
    bgView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:bgView];
    
    UILabel *text = [UILabel.alloc initWithFrame:bgView.bounds];
    text.textColor = UIColor.blackColor;
    text.text = @"abdfasdfasf";
    [bgView addSubview:text];
    
    maskLayer.mask = bgView.layer;
    bgView.frame = maskLayer.bounds;
//    text.frame = bgView.bounds;
    
    maskLayer.mask = text.layer;
    
    //这一步很重要
    //5. 一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    text.frame = maskLayer.bounds;
        //
}

- (void)startProgressLayer:(BOOL)dir {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    anim.duration = 3;
//    anim.fromValue = @(dir ? 0 : 200);
    anim.toValue = @(dir ? 200 : 0);
    anim.removedOnCompletion = NO;
    //保存动画最前面效果
    anim.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:anim forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.dir = !self.dir;
    [self.label startProgressLayer:self.dir];
}


@end

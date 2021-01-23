//
//  TSColorLabel.h
//  TSPickView
//
//  Created by Qincc on 2021/1/23.
//  Copyright © 2021 Galanz. All rights reserved.
//  可以将基类修改为UIControl

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSColorLabel : UIView

/// 文本颜色进度
@property (nonatomic, strong, readonly) CALayer *progressLayer;

/// 显示进度
@property (nonatomic, strong, readonly) CALayer *showProgressLayer;

/// 文本颜色显示的Layer
@property (nonatomic, strong, readonly) CALayer *maskLayer;

/// 文本控件 此处设置文本颜色无效， 只能设置文本属性，字体等等属性， 因为texLabe变成了maskLayer
@property (nonatomic, strong, readonly) UILabel *textLabel;

///  启动动画
/// @param direction   YES 从左到右。NO 从右到左
- (void)startProgressLayer:(BOOL)direction;

@end

NS_ASSUME_NONNULL_END

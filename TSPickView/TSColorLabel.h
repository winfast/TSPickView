//
//  TSColorLabel.h
//  TSPickView
//
//  Created by Qincc on 2021/1/23.
//  Copyright © 2021 Galanz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSColorLabel : UIView

/// 文本颜色进度
@property (nonatomic, strong, readonly) CALayer *progressLayer;

/// 显示进度
@property (nonatomic, strong, readonly) CALayer *showProgressLayer;

/// 文本颜色显示的Layer
@property (nonatomic, strong, readonly) CALayer *maskLayer;

/// 文本控件
@property (nonatomic, strong, readonly) UILabel *textLabel;


- (void)startProgressLayer:(BOOL)direction;

@end

NS_ASSUME_NONNULL_END

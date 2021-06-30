//
//  GHProgressButton.h
//  GHome
//
//  Created by Qincc on 2020/12/27.
//

#import <UIKit/UIKit.h>

@interface GHProgressButton : UIButton

/// 绘制进度的Layer
@property (nonatomic, strong, readonly) CAShapeLayer *shapeLayer;

@property (nonatomic) CGFloat progress;

+ (instancetype)buttonWithSize:(CGSize)size;

@end


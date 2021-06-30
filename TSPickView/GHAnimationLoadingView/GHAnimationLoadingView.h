//
//  GHAnimationLoadingView.h
//  Animation
//
//  Created by Qincc on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHAnimationLoadingView : UIView

@property (nonatomic, strong) UIColor *pathColor;

- (void)startAnimation;

- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END

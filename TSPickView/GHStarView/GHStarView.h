//
//  GHStarView.h
//  GHome
//
//  Created by Qincc on 2021/1/11.
//

#import <UIKit/UIKit.h>

@interface GHStarViewConfig : NSObject

///🌟的个数
@property (nonatomic) NSInteger starCount;

/// 🌟之间的间距
@property (nonatomic) CGFloat itemSpace;

/// 🌟  填满的图片名称
@property (nonatomic, copy) NSString *starFillImageName;

/// 🌟 空白的图片名称
@property (nonatomic, copy) NSString *starEmptyImageName;

@end


@interface GHStarView : UIView

+ (instancetype)starViewWithSize:(CGSize)size config:(GHStarViewConfig *)config;

- (void)updateStar:(CGFloat)starValue;

@end


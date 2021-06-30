//
//  GHSwitchButton.h
//  GHSwitchButton
//
//  Created by Qincc on 2021/1/6.
//

#import <UIKit/UIKit.h>


@interface GHSwitchButton : UIView

@property (nonatomic, weak) id<GHCustomEditDelegate> customDelegate;

- (void)reloadStatus:(BOOL)status;

@end


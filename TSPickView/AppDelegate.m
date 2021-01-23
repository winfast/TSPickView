//
//  AppDelegate.m
//  TSPickView
//
//  Created by QinChuancheng on 2020/7/27.
//  Copyright © 2020 Galanz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIViewController *vc = [[NSClassFromString(@"GHViewController") alloc] init];
	UINavigationController *nav = [UINavigationController.alloc initWithRootViewController:vc];
	self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
	self.window.rootViewController = nav;
	[self.window makeKeyAndVisible];
	
	return YES;
}



@end

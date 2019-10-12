//
//  AppDelegate.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "StockTabbarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    StockTabbarController *mainVC = [[StockTabbarController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
        if (!self.LearnInterFace) {
            return UIInterfaceOrientationMaskPortrait;
        }else{
            return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
        }
    
}





@end

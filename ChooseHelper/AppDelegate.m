//
//  AppDelegate.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "StockTabbarController.h"
#import "LoginViewController.h"
#import "RootDao.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[[RootDao alloc] init] createOrUpdateTable];
#if 1
    LoginViewController *mainVC = [[LoginViewController alloc] init];
#else
    StockTabbarController *mainVC = [[StockTabbarController alloc] init];
#endif
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    nav.navigationBar.hidden = YES;
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

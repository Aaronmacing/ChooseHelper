//
//  StockTabbarController.m
//  stockHelper
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StockTabbarController.h"
#import "BaseViewController.h"
#import "AViewController.h"
#import "BViewController.h"
@interface StockTabbarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) UIImageView *bkIV;

@end

@implementation StockTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    AViewController *mainVC = [[AViewController alloc] init];
    [self setChildVC:mainVC name:@"" image:@"" selectedImage:@""];
    
    BViewController *followVC = [[BViewController alloc] init];
    [self setChildVC:followVC name:@"" image:@"" selectedImage:@""];
    

    self.tabBar.translucent = NO;
    self.bkIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainTab"]];
    
    self.bkIV.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    self.bkIV.contentMode = UIViewContentModeScaleToFill;
    self.tabBar.barTintColor = [UIColor colorWithHexString:@"#FED6B5" alpha:1];
    [[self tabBar] addSubview:self.bkIV];
    
    
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    self.delegate = self;
    
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (self.selectedIndex == 0) {
        
        self.bkIV.image = [UIImage imageNamed:@"mainTab"];
    }else if(self.selectedIndex == 1){
        
        self.bkIV.image = [UIImage imageNamed:@"followTab"];
    }else if (self.selectedIndex == 2){
        
        self.bkIV.image = [UIImage imageNamed:@"marketTab"];
    }else if (self.selectedIndex == 3){
        
        self.bkIV.image = [UIImage imageNamed:@"infoTab"];
    }else if (self.selectedIndex == 4){
        
        self.bkIV.image = [UIImage imageNamed:@"meTab"];
        
    }
    
}


- (void)setChildVC:(BaseViewController *)childVC name:(NSString *)name image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.title = name;
    
    childVC.titleLabel.text = name;
    [self addChildViewController:childVC];
}


@end

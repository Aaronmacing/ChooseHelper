//
//  StockTabbarController.m
//  stockHelper
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StockTabbarController.h"
#import "BaseViewController.h"
#import "MainViewController.h"
#import "MarketViewController.h"
#import "TrainViewController.h"
#import "MyViewController.h"
@interface StockTabbarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) UIImageView *bkIV;

@end

@implementation StockTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    MainViewController *mainVC = [[MainViewController alloc] init];
    [self setChildVC:mainVC name:@"" image:@"" selectedImage:@""];
    
    MarketViewController *mkVC = [[MarketViewController alloc] init];
    [self setChildVC:mkVC name:@"" image:@"" selectedImage:@""];
    
    TrainViewController *trVC = [[TrainViewController alloc]init];
    [self setChildVC:trVC name:@"" image:@"" selectedImage:@""];
    
    MyViewController *followVC = [[MyViewController alloc] init];
    [self setChildVC:followVC name:@"" image:@"" selectedImage:@""];
    

    self.tabBar.translucent = NO;
    self.bkIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btm_1"]];
    
    self.bkIV.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    self.bkIV.contentMode = UIViewContentModeScaleToFill;
//    self.tabBar.barTintColor = [UIColor colorWithHexString:@"#FED6B5" alpha:1];
    [[self tabBar] addSubview:self.bkIV];
    
    
//    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToOtherPage) name:@"jump3" object:nil];
    
}

- (void)goToOtherPage
{
    [self setSelectedIndex:1];
    self.bkIV.image = [UIImage imageNamed:@"btm_2"];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (self.selectedIndex == 0) {
        
        self.bkIV.image = [UIImage imageNamed:@"btm_1"];
    }else if(self.selectedIndex == 1){
        
        self.bkIV.image = [UIImage imageNamed:@"btm_2"];
    }else if (self.selectedIndex == 2){
        
        self.bkIV.image = [UIImage imageNamed:@"btm_3"];
    }else if (self.selectedIndex == 3){
        
        self.bkIV.image = [UIImage imageNamed:@"btm_4"];
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

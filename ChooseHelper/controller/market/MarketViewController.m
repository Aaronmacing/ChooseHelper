//
//  Market ViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MarketViewController.h"
#import "HQViewController.h"
#import "ZXViewController.h"

@interface MarketViewController ()
@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)HQViewController *leftVC;
@property(nonatomic,strong)ZXViewController *rightVC;
@property(nonatomic,strong)UIViewController *showVC;
@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = YES;
    
    UIButton *btn = [UIButton new];
    [btn setBackgroundImage:kGetImage(@"hqselect") forState:UIControlStateNormal];
    [btn setBackgroundImage:kGetImage(@"zxselct") forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(selectBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(28);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
    // 初始化控制器
    [self controllersInit];

    // 初始化要展示的区域
    [self showViewInit];
}

- (void)controllersInit
{
    _leftVC = [HQViewController new];
    [self addChildViewController:_leftVC];
    [_leftVC didMoveToParentViewController:self];
    
    _rightVC  = [ZXViewController new];
    [self addChildViewController:_rightVC];
    [_rightVC didMoveToParentViewController:self];
    [_rightVC.view setFrame:self.view.bounds];
}

- (void)showViewInit
{
// 初始化要展示的区域
    self.showView = [UIView new];
    self.showView.frame = CGRectMake(0, HEIGHT_STATUSBAR + 44, Uni_kMainScreenWidth, Uni_kMainScreenHeight - 44 - HEIGHT_STATUSBAR);
    self.showView.layer.masksToBounds = YES;
    [self.view addSubview:_showView];

// 将第一个控制器的view添加进来展示
    [self.showView addSubview:_leftVC.view];

self.showVC = _leftVC;
}


- (void)selectBtnCliked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected == NO) {
        
        if (self.showVC == self.leftVC) {
            
        }
        else
        {
            [self transitionFromViewController:self.showVC
            toViewController:self.leftVC
                    duration:0.5
                     options:UIViewAnimationOptionTransitionNone
                  animations:^{



                  }
                  completion:^(BOOL finished) {
                      self.showVC = self.leftVC;
                  }];
        }
    }
    else
    {
        if (self.showVC == self.rightVC) {
                   
        }
        else
        {
            [self transitionFromViewController:self.showVC
                       toViewController:self.rightVC
                               duration:0.5
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{



                             }
                             completion:^(BOOL finished) {
                                 self.showVC = self.rightVC;
                             }];
        }
    }
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

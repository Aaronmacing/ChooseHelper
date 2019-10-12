//
//  InformationViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "InformationViewController.h"
#import "NewsViewController.h"
#import "ImportViewController.h"
#import "NewgpViewController.h"


@interface InformationViewController ()
@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)NewsViewController *leftVC;
@property(nonatomic,strong)ImportViewController *midleVC;
@property(nonatomic,strong)NewgpViewController *rightVC;
@property(nonatomic,strong)UIViewController *showVC;
@property(nonatomic,assign)NSInteger selectPlace;
@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   self.backImageView.image = kGetImage(@"bg");
   [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
       make.top.mas_equalTo(self.view.mas_top);
       make.bottom.mas_equalTo(self.view.mas_bottom);
       make.left.mas_equalTo(self.view.mas_left);
       make.right.mas_equalTo(self.view.mas_right);
       
   }];
    
    self.titleLabel.text = @"资讯广场";
   
   
   NSArray *array = @[@"新闻资讯",@"要闻解读",@"新股日历"];
   for (int i = 0; i < 3; i++) {
      
      UIButton *btn = [UIButton new];
      btn.tag = 10 + i;
      [btn addTarget:self action:@selector(selectBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
      [btn setBackgroundImage:kGetImage(@"ww_normal") forState:UIControlStateNormal];
      [btn setBackgroundImage:kGetImage(@"ww_select") forState:UIControlStateSelected];
      [btn setTitle:array[i] forState:UIControlStateNormal];
      [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
      [btn setTitleColor:[UIColor colorWithHexString:@"#FE4E7B" alpha:1] forState:UIControlStateSelected];
      [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
      [self.view addSubview:btn];
      [btn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo((Uni_kMainScreenWidth - 83 * 3) / 4 +  ((Uni_kMainScreenWidth - 83 * 3) / 4 + 83) * i);
         make.width.mas_equalTo(83);
         make.height.mas_equalTo(32);
         make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT_STATUSBAR + 45);
         
      }];
      
      if (i == 0) {
         btn.selected = YES;
      }
      
   }
   
   
   self.selectPlace = 0;
    
    
    // 初始化控制器
    [self controllersInit];

    // 初始化要展示的区域
    [self showViewInit];
    
    
}


- (void)controllersInit
{
    _leftVC = [NewsViewController new];
    [self addChildViewController:_leftVC];
    [_leftVC didMoveToParentViewController:self];
    
    
    _midleVC = [ImportViewController new];
    [self addChildViewController:_midleVC];
    [_midleVC didMoveToParentViewController:self];
    [_midleVC.view setFrame:self.view.bounds];
    
    _rightVC  = [NewgpViewController new];
    [self addChildViewController:_rightVC];
    [_rightVC didMoveToParentViewController:self];
    [_rightVC.view setFrame:self.view.bounds];
}

- (void)showViewInit
{
// 初始化要展示的区域
    self.showView = [UIView new];
    self.showView.frame = CGRectMake(7, 113 - 20 + HEIGHT_STATUSBAR, Uni_kMainScreenWidth - 14, Uni_kMainScreenHeight - (113 - 20 + HEIGHT_STATUSBAR));
    self.showView.layer.masksToBounds = YES;
    [self.view addSubview:_showView];

// 将第一个控制器的view添加进来展示
    [self.showView addSubview:_leftVC.view];

    self.showVC = _leftVC;
}




- (void)selectBtnCliked:(UIButton *)sender
{
   
   if (sender.tag == 10 + self.selectPlace) {
      
   }
   else
   {
      if (sender.tag == 10) {
         
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
         
         sender.selected = YES;
         UIButton *btn = [self.view viewWithTag:10 + self.selectPlace];
         btn.selected = NO;
         self.selectPlace = sender.tag - 10;
         
      }
      else if(sender.tag == 11)
      {
         if (self.showVC == self.midleVC) {
                    
         }
         else
         {
             [self transitionFromViewController:self.showVC
                        toViewController:self.midleVC
                                duration:0.5
                                 options:UIViewAnimationOptionTransitionNone
                              animations:^{



                              }
                              completion:^(BOOL finished) {
                                  self.showVC = self.midleVC;
                              }];
            sender.selected = YES;
            UIButton *btn = [self.view viewWithTag:10 + self.selectPlace];
            btn.selected = NO;
            self.selectPlace = sender.tag - 10;
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
            sender.selected = YES;
            UIButton *btn = [self.view viewWithTag:10 + self.selectPlace];
            btn.selected = NO;
            self.selectPlace = sender.tag - 10;
         }
         
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

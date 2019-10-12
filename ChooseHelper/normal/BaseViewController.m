//
//  BaseViewController.m
//  trafficRecord
//
//  Created by Apple on 2019/7/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "AppMacro.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    UIImageView *backgroundImage = [UIImageView new];
    backgroundImage.image = kGetImage(@"nav_bg");
    backgroundImage.backgroundColor = [UIColor whiteColor];
    backgroundImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:backgroundImage];
    
    self.backImageView = backgroundImage;
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(44 + HEIGHT_STATUSBAR);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT_STATUSBAR);
        make.width.mas_equalTo(Uni_kMainScreenWidth - 88);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    self.titleLabel = label;
    
    UIButton *back = [UIButton new];
    [back setImage:kGetImage(@"back") forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).with.offset( HEIGHT_STATUSBAR);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view.mas_left);
        
    }];
    self.backBtn = back;
    
    UIButton *clear = [UIButton new];
    [clear setImage:kGetImage(@"clear") forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clear];
    [clear mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).with.offset( HEIGHT_STATUSBAR);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.view.mas_right);
        
    }];
    self.deleteBtn = clear;
    
    self.account = [[AccountDao sharedAccountDao] queryLoginUser];
    
}

- (void)backBtnCliked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearBtnCliked:(UIButton *)sender
{
    
}

/**
 *  显示等待
 */
-(void)showWaiting{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

/**
 *  隐藏等待
 */
-(void)dismissWaiting{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)dismissWaitingWithShowToast:(NSString *)msg{
    [self dismissWaiting];
    [self showToast:msg];
}

/**
 *  显示提示消息
 */
- (void)showToast:(NSString *)msg{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.margin = 10.f;
    //hud.offset = CGP
    hud.offset = CGPointMake(hud.offset.x, Uni_kMainScreenHeight * 0.333);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
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

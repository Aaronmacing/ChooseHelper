//
//  VersionViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "VersionViewController.h"
#import "UIView+Util.h"
#import "AppMacro.h"
@interface VersionViewController ()

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"版本信息";
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = kGetImage(@"p_lg");
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(89);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(85);
        
    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15] text:@"版本信息：1.0" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(imageView.mas_bottom).with.offset(20);
        
    }];
    
    [imageView addTarget:self action:@selector(check)];
}

- (void)check{
    
    [self showToast:@"已是最新"];
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
    hud.offset = CGPointMake(hud.offset.x, SCREEN_HEIGHT * 0.3333);
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

//
//  SignViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SignViewController.h"

@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = YES;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = kGetImage(@"header");
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(107);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(20);
        
    }];
    
    UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:17] text:@"选股大师" textColor:[UIColor whiteColor]];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(24);
        
    }];
    
    NSArray *array1 = @[@"name_i",@"secrect_i",@"secrect_i"];
    NSArray *array2 = @[@"由4-16位字母、数字或汉字组成",@"由6-16位字母、数字或符号组成",@"由6-16位字母、数字或符号组成"];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = kGetImage(array1[i]);
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-133);
            
            if (i == 0) {
            
                make.width.mas_equalTo(23);
            }
            else
            {
                make.width.mas_equalTo(21);
            }
            
            
            make.height.mas_equalTo(24);
            make.top.mas_equalTo(label.mas_bottom).with.offset(50 + 62 * i);
            
        }];
        
        
        
        
        UITextField *tf = [UITextField new];
        tf.tag = 20 + i;
        tf.background = kGetImage(@"tf_bg");
        NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc] initWithString:array2[i] attributes:
                                                     @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#D1D0D0" alpha:1],
                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}];
        
        tf.attributedPlaceholder = placeholderStr;
        
        
        tf.font = [UIFont systemFontOfSize:14];
        tf.textColor = [UIColor darkTextColor];
        tf.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView.mas_centerY);
            make.height.mas_equalTo(39);
            make.width.mas_equalTo(233);
            make.left.mas_equalTo(imageView.mas_right).with.offset(16);
            
        }];
        
        
        UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 39)];
        UIView *right = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 39)];
        tf.leftView = left;
        tf.rightView = right;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.rightViewMode = UITextFieldViewModeAlways;
        
    }
    
    
    UIButton *spBtn = [UIButton new];
    [spBtn setBackgroundImage:kGetImage(@"sign") forState:UIControlStateNormal];
    [spBtn addTarget:self action:@selector(spBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spBtn];
    [spBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(158);
        make.top.mas_equalTo(label.mas_bottom).with.offset(250);
        
    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] text:@"已有账号，前往登录>>>" textColor:[UIColor whiteColor]];
    label2.userInteractionEnabled = YES;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spBtn.mas_left).with.offset(-54);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(13);
        make.top.mas_equalTo(spBtn.mas_bottom).with.offset(17);
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [label2 addGestureRecognizer:tap];
    
    
}

- (void)tap
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)spBtnCliked:(UIButton *)sender
{
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

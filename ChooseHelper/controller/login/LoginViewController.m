//
//  LoginViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "StockTabbarController.h"
#import "SignViewController.h"
#import "StockTabbarController.h"

@interface LoginViewController ()
@property(nonatomic,assign)BOOL save;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = YES;
    
    self.backImageView.image = kGetImage(@"bg");
    [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        
    }];
    
    
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = kGetImage(@"header");
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(107);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(20);
        
    }];
    
    UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:17] text:@"股 参 谋" textColor:[UIColor whiteColor]];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(24);
        
    }];
    
    NSArray *array1 = @[@"name_i",@"secrect_i"];
    NSArray *array2 = @[@"由4-16位字母、数字或汉字组成",@"由6-16位字母、数字或符号组成"];
    
    for (int i = 0; i < 2; i++) {
        
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
        if (i != 0) {
            
            tf.secureTextEntry = YES;
        }
        
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
    [spBtn setBackgroundImage:kGetImage(@"login") forState:UIControlStateNormal];
    [spBtn addTarget:self action:@selector(spBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spBtn];
    [spBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(158);
        make.top.mas_equalTo(label.mas_bottom).with.offset(219);
        
    }];
    
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] text:@"记住密码" textColor:[UIColor whiteColor]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spBtn.mas_right).with.offset(6);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(spBtn.mas_top).with.offset(-39);
        
    }];
    
    UIButton *opBtn = [UIButton new];
    opBtn.selected = YES;
    [opBtn setImageEdgeInsets:UIEdgeInsetsMake(5.5, 5.5, 5.5, 5.5)];
    [opBtn setImage:kGetImage(@"select") forState:UIControlStateSelected];
    [opBtn setImage:kGetImage(@"un_selec") forState:UIControlStateNormal];
    [opBtn addTarget:self action:@selector(opBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:opBtn];
    [opBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label1.mas_centerY);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
        make.right.mas_equalTo(label1.mas_left);
        
    }];
    
    
    
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] text:@"没有账号，立即注册>>>" textColor:[UIColor whiteColor]];
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
    
    
    self.save = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *a = [user stringForKey:@"account"];
    NSString *b = [user stringForKey:@"secret"];
    UITextField *tf1 = [self.view viewWithTag:20];
    UITextField *tf2 = [self.view viewWithTag:21];
    tf1.text = a;
    tf2.text = b;
    tf2.secureTextEntry = YES;
}


- (void)tap
{
    SignViewController *vc = [[SignViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)opBtnCliked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.save = !self.save;
}

- (void)spBtnCliked:(UIButton *)sender
{
    UITextField *tf1 = [self.view viewWithTag:20];
    UITextField *tf2 = [self.view viewWithTag:21];
    
    
    if (tf1.text.length >= 4 && tf1.text.length <= 16 && tf2.text.length >= 6 && tf2.text.length <= 16) {
        
        StockTabbarController *vc = [[StockTabbarController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        if (self.save == YES) {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:tf1.text forKey:@"account"];
            [user setObject:tf2.text forKey:@"secret"];
            [user synchronize];
        }
        else
        {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"" forKey:@"account"];
            [user setObject:@"" forKey:@"secret"];
            [user synchronize];
        }
        
        
    }
    else
    {
        [MBProgressHUD showError:@"数据不正确,请重新输入!"];
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

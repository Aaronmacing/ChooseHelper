//
//  ChangesecretViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ChangesecretViewController.h"

@interface ChangesecretViewController ()

@end

@implementation ChangesecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = NO;
    self.titleLabel.text = @"修改密码";
    
    
    
    NSArray *array1 = @[@"旧密码",@"新密码",@"确认密码"];
    NSArray *array2 = @[@"请填写旧密码",@"请填写新密码",@"请填写新密码"];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = kGetImage(@"fgx");
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(51 + 48 * i);
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(self.view.mas_left).with.offset(18);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
            
        }];
        
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:array1[i] textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.left.mas_equalTo(self.view.mas_left).with.offset(18);
                make.width.mas_equalTo(60);
                make.height.mas_equalTo(15);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(24 + 48 * i);
            
        }];
        
        UIButton *czBtn = [UIButton new];
        czBtn.tag = 20 + i;
        [czBtn setBackgroundImage:kGetImage(@"un_can_see") forState:UIControlStateNormal];
        [czBtn setBackgroundImage:kGetImage(@"can_see") forState:UIControlStateSelected];
        [czBtn addTarget:self action:@selector(cancelBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:czBtn];
        [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(26);
            make.height.mas_offset(17);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(18 + 48 * i);

        }];
        
        
        
        UITextField *tf = [UITextField new];
        tf.font = [UIFont systemFontOfSize:14];
        tf.textColor = [UIColor colorWithHexString:@"#0B70F4" alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        
        tf.tag = 10 + i;
        tf.secureTextEntry = YES;
        
        [self.view addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo(label1.mas_right).with.offset(41);
            make.height.mas_offset(45);
            make.centerY.mas_equalTo(label1.mas_centerY);
            make.right.mas_equalTo(czBtn.mas_left).with.offset(-41);

        }];
        
        NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc] initWithString:array2[i] attributes:
                                                     @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#9B9B9B" alpha:1],
                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:12]}];

        tf.attributedPlaceholder = placeholderStr;
        
        
    }
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:10] text:@"可包含字母、数字，限6-16个字符" textColor:[UIColor colorWithHexString:@"#6C6C6C" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.mas_equalTo(self.view.mas_left).with.offset(18);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(166);
        
    }];
    
    UIButton *sureBtn = [UIButton new];
    [sureBtn setBackgroundImage:kGetImage(@"sure") forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(200);
        make.height.mas_offset(45);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(236);

    }];
    
}

- (void)cancelBtnCliked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
    UITextField *tf = [self.view viewWithTag:sender.tag - 10];
    tf.secureTextEntry = !sender.selected;
    
    
}

- (void)sureBtnCliked:(UIButton *)sender
{
    UITextField *tf1 = [self.view viewWithTag:10];
    UITextField *tf2 = [self.view viewWithTag:11];
    UITextField *tf3 = [self.view viewWithTag:12];
    
    if (tf1.text.length >= 6 && tf1.text.length <= 16 && tf2.text.length >= 6 && tf2.text.length <= 16 && [tf2.text isEqualToString:tf3.text]) {
        
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

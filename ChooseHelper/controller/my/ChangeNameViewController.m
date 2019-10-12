//
//  ChangeNameViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "AccountDao.h"
#import "UserRequestServer.h"
#import "NSString+StringUtil.h"
@interface ChangeNameViewController ()
@property(nonatomic,strong)UITextField *textField;


@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backBtn.hidden = NO;
    self.titleLabel.text = @"修改用户名";
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = kGetImage(@"fgx");
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(52);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
        
    }];
    
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:@"用户名" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.mas_equalTo(self.view.mas_left).with.offset(18);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(24);
        
    }];
    
    UIButton *czBtn = [UIButton new];
    [czBtn setBackgroundImage:kGetImage(@"cancel") forState:UIControlStateNormal];
    [czBtn addTarget:self action:@selector(cancelBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:czBtn];
    [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(21);
        make.height.mas_offset(21);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(19);

    }];
    
    
    UITextField *tf = [UITextField new];
    tf.font = [UIFont systemFontOfSize:13];
    tf.textColor = [UIColor colorWithHexString:@"#9B9B9B" alpha:1];
    tf.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(label1.mas_right).with.offset(41);
        make.height.mas_offset(45);
        make.centerY.mas_equalTo(label1.mas_centerY);
        make.right.mas_equalTo(czBtn.mas_left).with.offset(-41);

    }];
    self.textField = tf;
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:10] text:@"以英文字母或汉字开头，限4-16个字符" textColor:[UIColor colorWithHexString:@"#6C6C6C" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.mas_equalTo(self.view.mas_left).with.offset(18);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(imageView.mas_bottom).with.offset(17);
        
    }];
    
    UIButton *sureBtn = [UIButton new];
    [sureBtn setBackgroundImage:kGetImage(@"sure") forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(200);
        make.height.mas_offset(45);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(60);

    }];
    
    self.account = [[AccountDao sharedAccountDao] queryLoginUser];
    
    if ([NSString isNotBlankString:self.account.name]) {
        
        self.textField.text = self.account.name;
    }
}


- (void)cancelBtnCliked:(UIButton *)sender{
    self.textField.text = @"";
}


- (void)sureBtnCliked:(UIButton *)sender{
    

    if ([NSString isBlankString:self.textField.text]) {
         
         [self showToast:@"请输入昵称"];
         return;
     }
    
    if ([self.textField.text isEqualToString:self.account.name]) {
        
        [self showToast:@"用户名已存在"];
        return;
    }
    
    self.account.name = self.textField.text;
    [[AccountDao sharedAccountDao] insertOrUpdateData:self.account];
    
    [[UserRequestServer sharedUserRequestServer] changeUserInfoByUUID:self.account.uuid avatar:nil name:self.account.name success:^{
        
        [self dismissWaitingWithShowToast:@"修改个人信息成功"];
        
        if (self.changeName) {
            
            self.changeName(self.account.name);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInfo" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString * _Nonnull msg) {
        
        [self dismissWaitingWithShowToast:msg];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInfo" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
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

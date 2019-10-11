//
//  AboutViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITextViewDelegate>
@property (nonatomic,strong)UITextView *otherField;
@property (nonatomic, strong)UILabel *lb;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"联系我们";
    
    UITextView *tf = [UITextView new];
    tf.layer.cornerRadius = 10;
    tf.layer.borderWidth = 1;
    tf.textAlignment = NSTextAlignmentLeft;
    tf.delegate = self;
    tf.layer.borderColor = [UIColor colorWithHexString:@"#0B70F4" alpha:1].CGColor;
    tf.layer.masksToBounds = YES;
    tf.font = [UIFont systemFontOfSize:13];
    tf.textColor = [UIColor colorWithHexString:@"#0B70F4" alpha:1];
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(15);
        make.height.mas_equalTo(207);
        
    }];
    
    UIButton *sureBtn = [UIButton new];
    [sureBtn setBackgroundImage:kGetImage(@"tjfk") forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(200);
        make.height.mas_offset(45);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(tf.mas_bottom).with.offset(19);

    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:@"客服邮箱：123@kf.com" textColor:[UIColor colorWithHexString:@"#9B9B9B" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(14);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR - 20);
        
    }];
}

- (void)sureBtnCliked:(UIButton *)sender
{
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请填写内容"]) {
        
        textView.text = @"";
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

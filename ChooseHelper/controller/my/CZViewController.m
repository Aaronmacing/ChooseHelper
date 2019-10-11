//
//  CZViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CZViewController.h"

@interface CZViewController ()
@property(nonatomic,assign)NSInteger selectTag;
@end

@implementation CZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = NO;
    self.titleLabel.text = @"账户充值";
    NSArray *array = @[@"￥68",@"￥108",@"￥158",@"￥198",@"￥258",@"￥308",@"￥388",@"￥488",@"￥588"];
    NSArray *array2 = @[@"送500金币",@"送100金币",@"送2000金币"];
    for (int i = 0; i < 9; i++) {
        
        UIButton *czBtn = [UIButton new];
        czBtn.tag = 20 + i;
        [czBtn setBackgroundImage:kGetImage(@"2") forState:UIControlStateNormal];
        [czBtn setBackgroundImage:kGetImage(@"1") forState:UIControlStateSelected];
        [czBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [czBtn setTitleColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1] forState:UIControlStateNormal];
        [czBtn setTitle:array[i] forState:UIControlStateNormal];
        [czBtn addTarget:self action:@selector(goToCZBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:czBtn];
        [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(71);
            make.height.mas_offset(39);
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-115 + 115 * (i % 3));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(24 + (39 + 17) * (i / 3));
            
        }];
        
        if (i == 0) {
            czBtn.selected = YES;
        }
        
        if ( (i  + 1) % 3 == 0) {
            
            UIButton *aBtn = [UIButton new];
            [aBtn setBackgroundImage:kGetImage(@"3") forState:UIControlStateNormal];
            [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [aBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
            [aBtn setTitle:array2[(i + 1) / 3 - 1] forState:UIControlStateNormal];
            [self.view addSubview:aBtn];
            [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.width.mas_equalTo(63);
                make.height.mas_offset(13);
                make.right.mas_equalTo(czBtn.mas_right);
                make.top.mas_equalTo(czBtn.mas_top).with.offset(-8);
                
            }];
        }
        
        
        
    }
    
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:13] text:@"到账金币数量：" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-115);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(207);
        
    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:13] text:@"1000" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(115);
               make.width.mas_equalTo(90);
               make.height.mas_equalTo(15);
               make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(207);
        
    }];
    
    UIButton *czBtn = [UIButton new];
    [czBtn setBackgroundImage:kGetImage(@"ljcz") forState:UIControlStateNormal];
    [czBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:czBtn];
    [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(154);
        make.height.mas_offset(38);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(27);

    }];

}

- (void)goToCZBtn:(UIButton *)sender
{
    
    
    if (sender.tag - 20 == self.selectTag) {
        
    }
    else
    {
        sender.selected = !sender.selected;
        
        
        UIButton *btn = [self.view viewWithTag:20 + self.selectTag];
        btn.selected = NO;
        self.selectTag = sender.tag - 20;
        
        
    }
}

- (void)nextStep
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

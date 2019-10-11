//
//  GPXQViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "GPXQViewController.h"
#import "BuysellViewController.h"

@interface GPXQViewController ()
@property(nonatomic,assign)NSInteger leftSelect;
@end

@implementation GPXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"股票详情";
    
        
    for (int i = 0; i < 2; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:@"西部资源" textColor:[UIColor colorWithHexString:@"#FF0004" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-100 + 200 * i);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(8);
            
        }];
        
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:9] text:@"+0.37 +0.37" textColor:[UIColor colorWithHexString:@"#FF0004" alpha:1]];
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(label1.mas_centerX);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(9);
            make.top.mas_equalTo(label1.mas_bottom).with.offset(12);
            
        }];
        
    }
    
    NSArray *array = @[@"今开",@"昨收",@"最高",@"最低",@"成交量",@"成交额"];
    double p = (Uni_kMainScreenWidth - 34) / 3;
    for (int i = 0; i < 6; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array[i] textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left).with.offset(17 + p * (i % 3));
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(62 + 28 * (i / 3));
            
        }];
        
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:@"10.8万手" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
        
        if (i == 0 || i == 2) {
            label2.textColor = [UIColor colorWithHexString:@"#FF0004" alpha:1];
        }
        else if (i == 1 || i == 3) {
            label2.textColor = [UIColor colorWithHexString:@"#0A900A" alpha:1];
        }
        
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(label1.mas_centerY);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(label1.mas_right).with.offset(10);
            
        }];
    }
    

    UIImageView *fgx = [UIImageView new];
    fgx.image = kGetImage(@"gpxqfgx");
    [self.view addSubview:fgx];
    [fgx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(Uni_kMainScreenWidth);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(111);
    }];
    
    
    
    NSArray *array1 = @[@"分时",@"日K",@"周K",@"月K"];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = 10 + i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setTitle:array1[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#131313" alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithHexString:@"#FF0004" alpha:1] forState:UIControlStateSelected];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset( Uni_kMainScreenWidth / 4 * i);
            make.width.mas_equalTo(Uni_kMainScreenWidth / 4);
            make.height.mas_equalTo(22);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(120);
        }];
        
        if (i == 0) {
            btn.selected = YES;
            self.leftSelect = 0;
            
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = [UIColor colorWithHexString:@"#FF0004" alpha:1];
            imageView.tag = 9;
            [self.view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn.mas_centerX);
                make.width.mas_equalTo(34);
                make.height.mas_equalTo(2);
                make.bottom.mas_equalTo(btn.mas_bottom).with.offset(0);
            }];
            
        }
    }
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fgx.mas_bottom).with.offset(43);
        make.height.mas_equalTo(201);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    if (self.type == 0) {
     
        UIButton *aBtn = [UIButton new];
        [aBtn addTarget:self action:@selector(cpBtnClied:) forControlEvents:UIControlEventTouchUpInside];
        [aBtn setBackgroundImage:kGetImage(@"adddelete") forState:UIControlStateNormal];
        [self.view addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(self.view.mas_left);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR);
            
            
        }];
    }
    else
    {
        UIButton *aBtn = [UIButton new];
        [aBtn addTarget:self action:@selector(dpBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [aBtn setBackgroundImage:kGetImage(@"buyin") forState:UIControlStateNormal];
        [self.view addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(108);
            make.height.mas_equalTo(49);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR);
            
            
        }];
        
        UIButton *bBtn = [UIButton new];
        [bBtn addTarget:self action:@selector(apBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [bBtn setBackgroundImage:kGetImage(@"seelout") forState:UIControlStateNormal];
        [self.view addSubview:bBtn];
        [bBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(108);
            make.height.mas_equalTo(49);
            make.right.mas_equalTo(aBtn.mas_left);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR);
            
            
        }];
    }
}

- (void)cpBtnClied:(UIButton *)sender
{
    
}

- (void)dpBtnCliked:(UIButton *)sender
{
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)apBtnCliked:(UIButton *)sender
{
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)leftBtnCliked:(UIButton *)sender
{
    if (sender.tag - 10 == self.leftSelect) {
        
    }
    else
    {
        sender.selected = YES;
        UIButton *btn = [self.view viewWithTag:10 + self.leftSelect];
        btn.selected = NO;
        
        self.leftSelect = sender.tag - 10;
        UIImageView *imageView = [self.view viewWithTag:9];
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(sender.mas_centerX);
            make.width.mas_equalTo(34);
            make.height.mas_equalTo(2);
            make.bottom.mas_equalTo(sender.mas_bottom).with.offset(0);
        }];
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

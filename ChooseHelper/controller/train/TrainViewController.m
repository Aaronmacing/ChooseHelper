//
//  TrainViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TrainViewController.h"
#import "XLYTableViewCell.h"
#import "BuysellViewController.h"
#import "GPXQViewController.h"
#import "TransactionRecordViewController.h"

@interface TrainViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"模拟交易中心";
    
    [self.backBtn setImage:kGetImage(@"jy_btn") forState:UIControlStateNormal];
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).with.offset( HEIGHT_STATUSBAR);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    
    UIImageView *backImage = [UIImageView new];
    backImage.image = kGetImage(@"jy_bg");
    [self.view addSubview:backImage];
    [backImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset( 0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    NSArray *array1 = @[@"昨日盈亏",@"持仓盈亏",@"累计收益"];
    NSArray *array2 = @[@"+1012.56",@"+1516.24",@"+3614.28"];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array1[i] textColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left).with.offset(0 + Uni_kMainScreenWidth / 3 * i);
            make.width.mas_equalTo(Uni_kMainScreenWidth / 3);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(8);
            
        }];
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array2[i] textColor:[UIColor colorWithHexString:@"#FF0000" alpha:1]];
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(label1.mas_left);
            make.width.mas_equalTo(label1.mas_width);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(label1.mas_bottom).with.offset(16);
            
        }];
    }
    
    NSArray *array3 = @[@"总市值",@"可用资金"];
    NSArray *array4 = @[@"3,000.00",@"3,000.00"];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array3[i] textColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left).with.offset(Uni_kMainScreenWidth / 4 + Uni_kMainScreenWidth / 4 * i);
            make.width.mas_equalTo(Uni_kMainScreenWidth / 4);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(74);
            
        }];
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array4[i] textColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(label1.mas_left);
            make.width.mas_equalTo(label1.mas_width);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(label1.mas_bottom).with.offset(11);
            
        }];
    }
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:@"当前持仓" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(25);
        make.width.mas_equalTo(Uni_kMainScreenWidth / 4);
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(121);
        
    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:14] text:@"仓位：30.00%" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right).with.offset(-25);
        make.width.mas_equalTo(label1.mas_width);
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(label1.mas_top);
        
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.emptyDataSetSource = self;
     self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XLYTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"XLYTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(139);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    [self.view bringSubviewToFront:self.backBtn];
    
}

- (void)backBtnCliked:(UIButton *)sender
{
    TransactionRecordViewController *vc = [[TransactionRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"XLYTableViewCell";
    XLYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[XLYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.butBtn.tag = 1000 + indexPath.section;
    cell.sellBtn.tag = 2000 + indexPath.section;
    cell.hqBtn.tag = 3000 + indexPath.section;
    [cell.butBtn addTarget:self action:@selector(buyBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.sellBtn addTarget:self action:@selector(sellBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.hqBtn addTarget:self action:@selector(hqBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"no_image");
}

- (void)buyBtnCliked:(UIButton *)sender
{
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sellBtnCliked:(UIButton *)sender
{
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hqBtnCliked:(UIButton *)sender
{
    GPXQViewController *vc = [[GPXQViewController alloc]init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
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

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
#import "StockRequetServer.h"

@interface TrainViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *localData;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger total;
@property(nonatomic,assign)double canUse;
@property(nonatomic,copy)NSArray *idArray;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,strong)NSString *filePatch;
@property(nonatomic,assign)BOOL reload;
@property(nonatomic,strong)UILabel *cwLabel;


@end

@implementation TrainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_reload == YES) {
        
        self.reload = NO;
        [self readData];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"模拟交易中心";
    
    
    self.idArray = @[@"sh600000",@"sh600004",@"sh600006",@"sh600007",@"sh600008"];
    
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
    NSArray *array2 = @[@"+0.00",@"+0.00",@"+0.00"];
    
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
        label2.tag = 10 + i;
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(label1.mas_left);
            make.width.mas_equalTo(label1.mas_width);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(label1.mas_bottom).with.offset(16);
            
        }];
    }
    
    NSArray *array3 = @[@"总市值",@"可用资金"];
    NSArray *array4 = @[@"0.00",@"0.00"];
    
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
        label2.tag = 20 + i;
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
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:14] text:@"仓位：0.00%" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right).with.offset(-25);
        make.width.mas_equalTo(label1.mas_width);
        make.height.mas_equalTo(14);
        make.top.mas_equalTo(label1.mas_top);
        
    }];
    
    self.cwLabel = label2;
    
    
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
    
    self.dataSource = [[NSMutableArray alloc]init];
    self.localData = [[NSMutableArray alloc]init];
    self.number = 0;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    self.filePatch = [path stringByAppendingPathComponent:@"info.plist"];//没有会自动创建
    
    [self initDataSource];
    
    
    
}

- (void)initDataSource

{
    
    [[StockRequetServer sharedStockRequetServer] getStockSingleByCode:self.idArray[self.number] type:nil stockMarket:Shanghai success:^(id stockSingle) {
        
        [self.dataSource addObject:stockSingle];
        
        if (self.number < 4) {
            
            self.number ++;
            [self initDataSource];
            
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self readData];
            
        }
        
    } failure:^(NSString *msg) {
        
    }];
    
}

- (void)readData
{
    
    NSMutableArray *sandBoxDataArray = [[NSMutableArray alloc]initWithContentsOfFile:self.filePatch];
    if (sandBoxDataArray == nil) {
        
        sandBoxDataArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 5; i++) {
            
            StockSingleResultVO *model0 = self.dataSource[i];
            DataSingle *model = model0.data;
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:model.gid forKey:@"id"];
            [dic setObject:@"0.00" forKey:@"price"];
            [dic setObject:@"0" forKey:@"num"];
            [dic setObject:@"0.00" forKey:@"percent"];
         
            [sandBoxDataArray addObject:dic];
        }
        
        [sandBoxDataArray writeToFile:self.filePatch atomically:YES];
        
    }
    [self.localData removeAllObjects];
    [self.localData addObjectsFromArray:sandBoxDataArray];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.canUse = [user doubleForKey:@"canUse"];
    if (self.canUse == 0) {
        
        self.canUse = 10000;
    }
    
    double totalSZ = 0;
    double oldTotalSZ = 0;
    double totalCanuse = self.canUse;
    double total = 0;
    for (int i = 0; i < 5; i++) {
        
        StockSingleResultVO *model0 = self.dataSource[i];
        DataSingle *model = model0.data;
        NSMutableDictionary *dic = self.localData[i];
        
        totalSZ = [dic[@"num"] intValue] * [model.nowPri doubleValue] + totalSZ;
        oldTotalSZ = [dic[@"num"] intValue] * [dic[@"price"] intValue] + oldTotalSZ;
        
    }
    
    total = totalSZ + totalCanuse;
    
    
    UILabel *label1 = [self.view viewWithTag:10];
    label1.text = [NSString stringWithFormat:@"%+0.2f",totalSZ - oldTotalSZ];
    
    UILabel *label2 = [self.view viewWithTag:11];
    label2.text = [NSString stringWithFormat:@"%+0.2f",totalSZ - oldTotalSZ];
    
    UILabel *label3 = [self.view viewWithTag:12];
    label3.text = [NSString stringWithFormat:@"%+0.2f",total - 10000];
    
    
    UILabel *label4 = [self.view viewWithTag:20];
    label4.text = [NSString stringWithFormat:@"%0.2f",totalSZ];
    
    UILabel *label5 = [self.view viewWithTag:21];
    label5.text = [NSString stringWithFormat:@"%0.2f",totalCanuse];
    
    
    self.cwLabel.text = [NSString stringWithFormat:@"仓位：%0.2f%%",totalSZ / total * 100];
    
    
    
    [self.tableView reloadData];
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
    return self.dataSource.count;
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
    
    StockSingleResultVO *model0 = self.dataSource[indexPath.section];
    DataSingle *model = model0.data;
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@-%@",model.name,[model.gid uppercaseString]];
    cell.changeLabel.text = [NSString stringWithFormat:@"%@%%  %@",model.increPer,model.increase];
    cell.nowLabel.text = [NSString stringWithFormat:@"当前价  %@",model.nowPri];
    NSDictionary *dic = self.localData[indexPath.section];
    cell.buyLabel.text = [NSString stringWithFormat:@"成本价  %@",dic[@"price"]];
    cell.hasLabel.text = [NSString stringWithFormat:@"持  仓  %@",dic[@"num"]];
    cell.cwLabel.text = [NSString stringWithFormat:@"最新市值  %0.2f",[dic[@"num"] doubleValue] * [model.nowPri doubleValue]];
    
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
    self.reload = YES;
    
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 1;
    vc.model = self.dataSource[sender.tag - 1000];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sellBtnCliked:(UIButton *)sender
{
    self.reload = YES;
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 0;
    vc.model = self.dataSource[sender.tag - 2000];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hqBtnCliked:(UIButton *)sender
{
    self.reload = YES;
    GPXQViewController *vc = [[GPXQViewController alloc]init];
    vc.type = 1;
    
    StockSingleResultVO *model0 = self.dataSource[sender.tag - 3000];
    DataSingle *model = model0.data;
    vc.code = model.gid;
    vc.market = Shanghai;
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

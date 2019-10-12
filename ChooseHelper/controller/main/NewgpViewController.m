//
//  NewgpViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NewgpViewController.h"
#import "NewgpTableViewCell.h"
#import "StockRequetServer.h"
#import "StockListResultVO.h"

@interface NewgpViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> //实现滚动视图协议
{
    NSArray * _lisArr;

}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NewgpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
          self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 10;
    self.tableView.clipsToBounds = YES;
          self.tableView.delegate = self;
          self.tableView.dataSource = self;
           self.tableView.emptyDataSetSource = self;
           self.tableView.emptyDataSetDelegate = self;
          [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewgpTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"NewgpTableViewCell"];
          self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
          [self.view addSubview:self.tableView];
          
          [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.view.mas_top).with.offset(0);
              make.bottom.mas_equalTo(self.view.mas_bottom);
              make.left.mas_equalTo(self.view.mas_left).with.offset(0);
              make.right.mas_equalTo(self.view.mas_right).with.offset(0);
              
          }];
    
    
    
    [MBManager showWaitingWithTitle:@"加载中"];
    [[StockRequetServer sharedStockRequetServer] getStockListByPage:1 type:2 stockMarket:HongKong success:^(NSArray<StockListResultVO *> * _Nonnull stockList) {
        self->_lisArr = stockList;
        [self.tableView reloadData];
       
        [MBManager hideAlert];
    } failure:^(NSString * _Nonnull msg) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:msg inView:self.view];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    
    NSArray *array = @[@"申购时间",@"名称/代码",@"发行价",@"申购上限"];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:12] text:array[i] textColor:[UIColor colorWithHexString:@"#242E49" alpha:1]];
        label1.frame = CGRectMake((Uni_kMainScreenWidth - 14) / 4 * i, 0, (Uni_kMainScreenWidth - 14) / 4, 44);
        [self.view addSubview:label1];
    }
    
    
    
    return view;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _lisArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"NewgpTableViewCell";
    NewgpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NewgpTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    
    DataList * model = _lisArr[indexPath.row];
    [cell setDataVO:model];
   
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

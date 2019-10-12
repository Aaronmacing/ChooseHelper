//
//  TransactionRecordViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TransactionRecordViewController.h"
#import "TransactionRecordTableViewCell.h"

@interface TransactionRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation TransactionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"交易记录";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.emptyDataSetSource = self;
     self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TransactionRecordTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"TransactionRecordTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    [self readData];
}

- (void)readData
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePatch = [path stringByAppendingPathComponent:@"Data.plist"];//没有会自动创建
    
    NSMutableArray *sandBoxDataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePatch];
    if (sandBoxDataArray == nil) {
         sandBoxDataArray = [[NSMutableArray alloc]init];
    }
    
    self.dataSource = [[NSMutableArray alloc]init];
    
    [self.dataSource addObjectsFromArray:sandBoxDataArray];
    [self.tableView reloadData];
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"TransactionRecordTableViewCell";
    TransactionRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[TransactionRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    
    if ([dic[@"type"] intValue] == 1) {
        
        cell.flagImage.image = kGetImage(@"cell_flag_buy");
        cell.flagName.text = @"买入";
        cell.flagName.textColor = [UIColor colorWithHexString:@"#FF4242" alpha:1];
    }
    else
    {
        cell.flagImage.image = kGetImage(@"cell_flag_sell");
        cell.flagName.text = @"卖出";
        cell.flagName.textColor = [UIColor colorWithHexString:@"#0000FF" alpha:1];
    }
    
    cell.nameLabel.text = dic[@"name"];
    cell.timeLabel.text = dic[@"time"];
    cell.priceLabel.text = dic[@"price"];
    cell.numLabel.text = dic[@"num"];

   
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

//
//  NewsViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NewsViewController.h"
#import "MainTableViewCell.h"
#import "MessageViewController.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> //实现滚动视图协议
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NewsViewController

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
          [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
          self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
          [self.view addSubview:self.tableView];
          
          [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.view.mas_top).with.offset(0);
              make.bottom.mas_equalTo(self.view.mas_bottom);
              make.left.mas_equalTo(self.view.mas_left).with.offset(0);
              make.right.mas_equalTo(self.view.mas_right).with.offset(0);
              
          }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.textColor = [UIColor colorWithHexString:@"#242E49" alpha:1];
    cell.timeLabel.textColor = [UIColor colorWithHexString:@"#636363" alpha:1];
    cell.numLabel.textColor = [UIColor colorWithHexString:@"#636363" alpha:1];

   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
   MessageViewController *vc = [[MessageViewController alloc]init];
   [self.navigationController pushViewController:vc animated:YES];
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

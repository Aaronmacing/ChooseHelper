//
//  ZFPMViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ZFPMViewController.h"
#import "ZXTableViewCell.h"
#import "GPXQViewController.h"
@interface ZFPMViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,assign)NSInteger leftSelect;
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign) BOOL isSelected;

@end

@implementation ZFPMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"涨幅排名";
       
    self.view.backgroundColor = [UIColor whiteColor];
        
        
    
       self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
       self.tableView.backgroundColor = [UIColor whiteColor];
       self.tableView.delegate = self;
       self.tableView.dataSource = self;
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
       [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ZXTableViewCell"];
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       [self.view addSubview:self.tableView];
       
       [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(0);
           make.bottom.mas_equalTo(self.view.mas_bottom);
           make.left.mas_equalTo(self.view.mas_left).with.offset(0);
           make.right.mas_equalTo(self.view.mas_right).with.offset(0);
           
       }];
    
    
    self.isSelected = NO;
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#041833" alpha:1];
    NSArray *array = @[@"名称",@"最新单价",@"涨幅"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:15] text:array[i] textColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        label2.frame = CGRectMake(0 + ((Uni_kMainScreenWidth - 80 * 3) / 2 + 80) * i, 0, 80, 37);
        [view addSubview:label2];
        
        
        if (i == 2) {
            UIButton *addBtn = [UIButton new];
            [addBtn setBackgroundImage:kGetImage(@"jx_d") forState:UIControlStateNormal];
            [addBtn setBackgroundImage:kGetImage(@"sx_d") forState:UIControlStateSelected];
            [addBtn addTarget:self action:@selector(pxBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
            addBtn.frame = CGRectMake(Uni_kMainScreenWidth - 20, 6 + 5, 15, 15);
            [view addSubview:addBtn];
            addBtn.selected = self.isSelected;
        }
        
    }
          
    return view;
}

- (void)pxBtnCliked:(UIButton *)sender
{
    self.isSelected = !self.isSelected;
    
    self.dataSource = [[self.dataSource reverseObjectEnumerator] allObjects];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ZXTableViewCell";
    ZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ZXTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.dataSource && self.dataSource.count > 0) {
        
        cell.dataVO = self.dataSource[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DataList *dataList = self.dataSource[indexPath.row];
    
    GPXQViewController *vc = [[GPXQViewController alloc]init];
    vc.type = 0;
    vc.code = dataList.symbol;
    vc.market = self.market;
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

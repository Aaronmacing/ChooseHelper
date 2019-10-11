//
//  ZXViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ZXViewController.h"
#import "ZXTableViewCell.h"
#import "ZFPMViewController.h"

@interface ZXViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,assign)NSInteger leftSelect;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#041833" alpha:1];
    
    UIView *top = [UIView new];
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(Uni_kMainScreenWidth);
        make.height.mas_equalTo(37);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    
    
    NSArray *array = @[@"全部",@"沪深",@"港股",@"美股"];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = 10 + i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1] forState:UIControlStateSelected];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset( Uni_kMainScreenWidth / 4 * i);
            make.width.mas_equalTo(Uni_kMainScreenWidth / 4);
            make.height.mas_equalTo(37);
            make.top.mas_equalTo(self.view.mas_top);
        }];
        
        if (i == 0) {
            btn.selected = YES;
            self.leftSelect = 0;
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = kGetImage(@"btm_flag");
            imageView.tag = 9;
            [self.view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn.mas_centerX);
                make.width.mas_equalTo(34);
                make.height.mas_equalTo(2);
                make.bottom.mas_equalTo(btn.mas_bottom).with.offset(-6);
            }];
            
        }
    }
    
    
    
    
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
       make.top.mas_equalTo(top.mas_bottom).with.offset(0);
       make.height.mas_equalTo(32 + 37 * 5 + 62);
       make.left.mas_equalTo(self.view.mas_left).with.offset(0);
       make.right.mas_equalTo(self.view.mas_right).with.offset(0);
       
   }];
    
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
            make.bottom.mas_equalTo(sender.mas_bottom).with.offset(-6);
        }];
    }
}

- (void)czBtnCliked:(UIButton *)sender
{
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 62;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    NSArray *array = @[@"名称",@"最新单价",@"涨幅"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array[i] textColor:[UIColor colorWithHexString:@"#4F4F4F" alpha:1]];
        label2.frame = CGRectMake(0 + ((Uni_kMainScreenWidth - 80 * 3) / 2 + 80) * i, 0, 80, 32);
        [view addSubview:label2];
        
    }
          
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [UIView new];
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:17] text:@"添加自选" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
    label2.frame = CGRectMake(Uni_kMainScreenWidth / 2 - 50, 0, 75, 62);
    [view addSubview:label2];
    
    UIButton *addBtn = [UIButton new];
    [addBtn setBackgroundImage:kGetImage(@"zx_add") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(Uni_kMainScreenWidth / 2 - 50 + 75 + 10, 21, 20, 20);
    [view addSubview:addBtn];
    
    
    return view;
}


- (void)addBtnCliked:(UIButton *)sender
{
    ZFPMViewController *vc = [[ZFPMViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
    
    static NSString *identifier = @"ZXTableViewCell";
    ZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ZXTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

   
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


@end
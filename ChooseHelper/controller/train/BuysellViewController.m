//
//  BuysellViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BuysellViewController.h"
#import "SystemTradTableViewCell.h"
#import "CZViewController.h"

@interface BuysellViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,assign)NSInteger cbtnSelect;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BuysellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"浦发银行-600000.SH";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *top = [UIView new];
    top.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:top];
    
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(224);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    UILabel *nameLabel = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15] text:@"浦发银行-600000 SH" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
    nameLabel.layer.cornerRadius = 8;
    nameLabel.clipsToBounds = YES;
    nameLabel.layer.borderWidth = 1;
    nameLabel.layer.borderColor = [UIColor colorWithHexString:@"#0B70F4" alpha:1].CGColor;
    [top addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top.mas_top).with.offset(10);
        make.height.mas_equalTo(24);
        make.left.mas_equalTo(self.view.mas_left).with.offset(6);
        make.width.mas_equalTo(190);
        
    }];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15] text:@"11.37" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
        label.tag = 10 + i;
        label.layer.cornerRadius = 6;
        label.clipsToBounds = YES;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor colorWithHexString:@"#0B70F4" alpha:1].CGColor;
        [top addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(11 + 35 * i);
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.view.mas_left).with.offset(33);
            make.width.mas_equalTo(136);
            
        }];
        
        UIButton *aBtn = [UIButton new];
        [aBtn setBackgroundImage:kGetImage(@"ajj") forState:UIControlStateNormal];
        aBtn.tag = 20 + i;
        [aBtn addTarget:self action:@selector(jbtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(27);
            make.height.mas_offset(24);
            make.left.mas_equalTo(top.mas_left).with.offset(6);
            make.centerY.mas_equalTo(label.mas_centerY);

        }];
        
        UIButton *bBtn = [UIButton new];
        [bBtn setBackgroundImage:kGetImage(@"a++") forState:UIControlStateNormal];
        [bBtn addTarget:self action:@selector(addBtnClike:) forControlEvents:UIControlEventTouchUpInside];
        bBtn.tag = 30 + i;
        [top addSubview:bBtn];
        [bBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(27);
            make.height.mas_offset(24);
            make.left.mas_equalTo(label.mas_right).with.offset(0);
            make.centerY.mas_equalTo(label.mas_centerY);

        }];
        
        
    }
    
    NSArray *array1 = @[@"全仓",@"半仓",@"3/1仓",@"4/1仓"];
    for (int i = 0; i < 4; i++) {
        
        
        UIButton *aBtn = [UIButton new];
        [aBtn setBackgroundImage:kGetImage(@"cc_unselect") forState:UIControlStateNormal];
        [aBtn setBackgroundImage:kGetImage(@"cc_select") forState:UIControlStateSelected];
        [aBtn setTitle:array1[i] forState:UIControlStateNormal];
        [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [aBtn setTitleColor:[UIColor colorWithHexString:@"#041833" alpha:1] forState:UIControlStateNormal];
        [aBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
        aBtn.tag = 40 + i;
        [aBtn addTarget:self action:@selector(cangBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(45);
            make.height.mas_offset(24);
            make.left.mas_equalTo(top.mas_left).with.offset(6 + (45 + 4) * i);
            make.top.mas_equalTo(top.mas_top).with.offset(114);

        }];
    }
    
    
    UIButton *buyAndSell = [UIButton new];
    [buyAndSell setTitle:@"买入/卖出" forState:UIControlStateNormal];
    [buyAndSell setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [buyAndSell.titleLabel setFont: [UIFont boldSystemFontOfSize:13]];
    [buyAndSell addTarget:self action:@selector(buyAndSellBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [buyAndSell setBackgroundImage:kGetImage(@"buysell") forState:UIControlStateNormal];
    [top addSubview:buyAndSell];
    [buyAndSell mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(190);
        make.height.mas_offset(24);
        make.left.mas_equalTo(top.mas_left).with.offset(6);
        make.top.mas_equalTo(top.mas_top).with.offset(114 + 35);

    }];
    
    
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
     self.tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
         self.tableView.emptyDataSetSource = self;
         self.tableView.emptyDataSetDelegate = self;
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SystemTradTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"SystemTradTableViewCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [top addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top.mas_top).with.offset(5);
            make.bottom.mas_equalTo(top.mas_bottom).with.offset(0);
            make.left.mas_equalTo(nameLabel.mas_right).with.offset(20);
            make.right.mas_equalTo(self.view.mas_right).with.offset(0);
            
        }];
     
     
     
     UIImageView *imageView = [UIImageView new];
     imageView.contentMode = UIViewContentModeCenter;
     imageView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:imageView];
     
     [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(top.mas_bottom).with.offset(10);
         make.height.mas_equalTo(224);
         make.left.mas_equalTo(self.view.mas_left).with.offset(0);
         make.right.mas_equalTo(self.view.mas_right).with.offset(0);
         
     }];
     
     
     UILabel *mLabel = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:12] text:@"账户余额：100,000" textColor:[UIColor whiteColor]];
     [self.view addSubview:mLabel];
     [mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(imageView.mas_bottom).with.offset(44);
         make.height.mas_equalTo(24);
         make.centerX.mas_equalTo(self.view);
         make.width.mas_equalTo(290);
         
     }];
     
     UIButton *czBtn = [UIButton new];
     [czBtn setTitle:@"去充值>>" forState:UIControlStateNormal];
     [czBtn setTitleColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1] forState:UIControlStateNormal];
     [czBtn.titleLabel setFont: [UIFont boldSystemFontOfSize:10]];
     [czBtn addTarget:self action:@selector(czBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:czBtn];
     [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {

         make.width.mas_equalTo(100);
         make.height.mas_offset(15);
         make.centerX.mas_equalTo(self.view.mas_centerX);
         make.top.mas_equalTo(mLabel.mas_bottom).with.offset(5);

     }];
     
     
     UIButton *back = [UIButton new];
     [back setImage:kGetImage(@"refreSh") forState:UIControlStateNormal];
     [back addTarget:self action:@selector(refreShBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:back];
     [back mas_makeConstraints:^(MASConstraintMaker *make) {
         
         make.top.mas_equalTo(self.view.mas_top).with.offset( HEIGHT_STATUSBAR);
         make.width.mas_equalTo(44);
         make.height.mas_equalTo(44);
         make.right.mas_equalTo(self.view.mas_right);
         
     }];
        
}

- (void)refreShBtnCliked:(UIButton *)sender
{
     
}

- (void)jbtnCliked:(UIButton *)sender
{
    UILabel *label = [self.view viewWithTag:sender.tag - 10];
    
    if (sender.tag - 20 == 0) {
    
        label.text = [NSString stringWithFormat:@"%f",[label.text doubleValue] - 0.01];
    }
    else
    {
        label.text = [NSString stringWithFormat:@"%0.0f",[label.text doubleValue] - 1];
    }
    
}

- (void)addBtnClike:(UIButton *)sender
{
    UILabel *label = [self.view viewWithTag:sender.tag - 20];
    
    if (sender.tag - 20 == 0) {
    
        label.text = [NSString stringWithFormat:@"%f",[label.text doubleValue] + 0.01];
    }
    else
    {
        label.text = [NSString stringWithFormat:@"%0.0f",[label.text doubleValue] + 1];
    }
}

- (void)cangBtnCliked:(UIButton *)sender
{
    if(_cbtnSelect == sender.tag)
    {
        sender.selected = !sender.selected;
    }
    else
    {
        sender.selected = !sender.selected;
        
        if (_cbtnSelect != 0) {
            
            UIButton *btn = [self.view viewWithTag:self.cbtnSelect];
            btn.selected = NO;
        }
        
        
    }
    self.cbtnSelect = sender.tag;
}

- (void)buyAndSellBtnCliked:(UIButton *)sender
{
    
}


- (void)czBtnCliked:(UIButton *)sender
{
     CZViewController *vc = [[CZViewController alloc]init];
     [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     
     if (section == 0) {
          
          UIView *view = [UIView new];
          view.backgroundColor = [UIColor clearColor];
          return view;
     }
     else
     {
          UIView *view = [UIView new];
          
          CGFloat w = (Uni_kMainScreenWidth - 190 - 6 - 8 - 20) / 3;
          UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 2, w, 4)];
          imageView.image = kGetImage(@"sbfgx1");
          [view addSubview:imageView];
          
          UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(4 + w, 2, 2 * w, 4)];
          imageView2.image = kGetImage(@"sbfgx2");
          [view addSubview:imageView2];
          
          return view;
     }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SystemTradTableViewCell";
    SystemTradTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[SystemTradTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

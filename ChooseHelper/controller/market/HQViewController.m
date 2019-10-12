//
//  HQViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HQViewController.h"
#import "HQTableViewCell.h"
#import "ZFPMViewController.h"
#import "StockRequetServer.h"
//#import "MacVC.h"
#import <MJRefresh.h>
@interface HQViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,assign)NSInteger leftSelect;
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic,strong) UILabel *noDataLb;


/// 指数labels
@property (nonatomic,strong) NSMutableArray <UILabel *>*indexLbs;

/// 涨跌额labels
@property (nonatomic,strong) NSMutableArray <UILabel *>*changeAmountLbs;

/// 涨跌幅度labels
@property (nonatomic,strong) NSMutableArray <UILabel *>*changePercentageLbs;

@property (nonatomic,strong) UIImageView *topLineIV;

@property (nonatomic,strong) UIImageView *bottomLineIV;
@end

@implementation HQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *top = [UIView new];
    top.backgroundColor = [UIColor colorWithHexString:@"#041833" alpha:1];
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(Uni_kMainScreenWidth);
        make.height.mas_equalTo(37);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    self.indexLbs = @[].mutableCopy;
    self.changeAmountLbs = @[].mutableCopy;
    self.changePercentageLbs = @[].mutableCopy;
    
    NSArray *array = @[@"沪深",@"港股",@"美股"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = 10 + i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1] forState:UIControlStateSelected];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset( -103 + 103 * i);
            make.width.mas_equalTo(90);
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
    
    NSArray *array1 = @[@"g_a",@"g_b"];
    NSArray *array2 = @[@"上证指数",@"深证成指"];
    NSArray *array3= @[[UIColor colorWithHexString:@"#FF0000" alpha:1],[UIColor colorWithHexString:@"#33CC33" alpha:1],[UIColor colorWithHexString:@"#FF0000" alpha:1]];
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = kGetImage(array1[i]);
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(top.mas_bottom).with.offset(14);
                make.width.mas_equalTo(103);
                make.height.mas_equalTo(80);
            make.centerX.mas_equalTo(self.view).multipliedBy(i + 0.5);
            
        }];
        
        
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:12] text:array2[i] textColor:[UIColor whiteColor]];
        [imageView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(imageView.mas_left).with.offset(0);
            make.width.mas_equalTo(103);
            make.height.mas_equalTo(12);
            make.top.mas_equalTo(imageView.mas_top).with.offset(14);
            
        }];
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:14] text:@"10000.00" textColor:array3[i]];
        label2.tag = 10 + i;
        [imageView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
           make.left.mas_equalTo(imageView.mas_left).with.offset(0);
            make.width.mas_equalTo(103);
            make.height.mas_equalTo(12);
            make.top.mas_equalTo(label1.mas_bottom).with.offset(10);
            
        }];
        
        [self.indexLbs addObject:label2];
        
        UILabel *label3 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:10] text:@"10000.00" textColor:array3[i]];
        label3.tag = 20 + i;
        [imageView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
           make.left.mas_equalTo(imageView.mas_left).with.offset(0);
            make.width.mas_equalTo(103 / 2);
            make.height.mas_equalTo(8);
            make.top.mas_equalTo(label2.mas_bottom).with.offset(13);
            
        }];
        
        [self.changeAmountLbs addObject:label3];
        
        UILabel *label4 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:10] text:@"10000.00" textColor:array3[i]];
        label4.tag = 30 + i;
        [imageView addSubview:label4];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
           make.left.mas_equalTo(label3.mas_right).with.offset(0);
            make.width.mas_equalTo(103 / 2);
            make.height.mas_equalTo(8);
            make.top.mas_equalTo(label2.mas_bottom).with.offset(13);
            
        }];
        
        [self.changePercentageLbs addObject:label4];
    }
    
    NSArray *array4 = @[@"涨跌分布",@"涨幅榜"];
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = kGetImage(@"flag");
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(top.mas_bottom).with.offset(110 + (119 + 23) * i);
                make.width.mas_equalTo(7);
                make.height.mas_equalTo(23);
                make.left.mas_equalTo(self.view.mas_left).with.offset(8);
            
        }];
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:15] text:array4[i] textColor:[UIColor colorWithHexString:@"#242E49" alpha:1]];
        [imageView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(imageView.mas_right).with.offset(8);
            make.width.mas_equalTo(203);
            make.height.mas_equalTo(23);
            make.top.mas_equalTo(imageView.mas_top).with.offset(0);
            
        }];
        
        UIImageView *imageView1 = [UIImageView new];
        imageView1.image = kGetImage(@"ttttt");
        [self.view addSubview:imageView1];
        [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(imageView.mas_bottom).with.offset(3);
                make.height.mas_equalTo(1);
                make.right.mas_equalTo(self.view.mas_right).with.offset(-7);
                make.left.mas_equalTo(self.view.mas_left).with.offset(7);
            
        }];
        
        if (i == 0) {
            
            self.topLineIV = imageView1;
        }else{
         
            self.bottomLineIV = imageView1;
        }
       
        if (i == 1) {
            
            UIButton *czBtn = [UIButton new];
            [czBtn setTitle:@"更多..." forState:UIControlStateNormal];
            [czBtn setTitleColor:[UIColor colorWithHexString:@"#242E49" alpha:1] forState:UIControlStateNormal];
            [czBtn.titleLabel setFont: [UIFont boldSystemFontOfSize:12]];
            [czBtn addTarget:self action:@selector(czBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:czBtn];
            [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {

                make.width.mas_equalTo(60);
                make.height.mas_offset(23);
                make.centerY.mas_equalTo(imageView.mas_centerY);
                make.right.mas_equalTo(self.view.mas_right).with.offset(0);

            }];
            
        }
    }
    
    NSArray *array5 = @[@"zfgx",@"pfgx",@"dfgx"];
    NSArray *array6 = @[@"涨2440家",@"平250家",@"跌1060家"];
    NSArray *array7 = @[[UIColor colorWithHexString:@"#FF0033" alpha:1],[UIColor colorWithHexString:@"#AEAEAE" alpha:1],[UIColor colorWithHexString:@"#33CC33" alpha:1]];
    CGFloat w = (Uni_kMainScreenWidth - 46) / 4;
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView2 = [UIImageView new];
        imageView2.image = kGetImage(array5[i]);
        [self.view addSubview:imageView2];
        [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(top.mas_bottom).with.offset(164);
            make.height.mas_equalTo(4);
            if (i == 0) {
                make.left.mas_equalTo(self.view.mas_left).with.offset(16);
                make.width.mas_equalTo( 2 * w);
            }
            else
            {
                make.left.mas_equalTo(self.view.mas_left).with.offset(16 + 2 * w + 7 + (w + 7)* (i - 1));
                make.width.mas_equalTo(w);
            }
            
            
        }];
        
        UILabel *label0 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15] text:array6[i] textColor:array7[i]];
        [self.view addSubview:label0];
        [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(imageView2.mas_left);
            make.width.mas_equalTo(imageView2.mas_width);
            make.height.mas_equalTo(26);
            make.bottom.mas_equalTo(imageView2.mas_bottom);
            
        }];
        
        CGFloat p = (Uni_kMainScreenWidth - 32 - 11 * 24) / 10;
        if (i == 0) {
            
            NSArray *array = @[@"涨停",@">7%",@"7~5%",@"5~2%",@"2~0%"];
            for (int j = 0; j < 5; j++) {
                
                
                UILabel *label0 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:8] text:array[j] textColor:array7[i]];
                [self.view addSubview:label0];
                [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(10);
                    make.top.mas_equalTo(imageView2.mas_bottom).with.offset(61);
                    
                }];
                
                
                UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:9] text:@"" textColor:array7[i]];
                label1.backgroundColor = array7[i];
                [self.view addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(30);
                    make.bottom.mas_equalTo(imageView2.mas_bottom).with.offset(58);
                    
                }];
                
                
                UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:9] text:@"23%" textColor:array7[i]];
                [self.view addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(8);
                    make.bottom.mas_equalTo(label1.mas_top).with.offset(-3);
                    
                }];
            }
            
        }
        else if(i == 1)
        {
            NSArray *array = @[@"平"];
            for (int j = 0; j < 1; j++) {
                
                
                UILabel *label0 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:7] text:array[j] textColor:array7[i]];
                [self.view addSubview:label0];
                [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * 5 + p + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(10);
                    make.top.mas_equalTo(imageView2.mas_bottom).with.offset(61);
                    
                }];
                
                
                UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:9] text:@"" textColor:array7[i]];
                label1.backgroundColor = array7[i];
                [self.view addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * 5 + p + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(30);
                    make.bottom.mas_equalTo(imageView2.mas_bottom).with.offset(58);
                    
                }];
                
                
                UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:9] text:@"23%" textColor:array7[i]];
                [self.view addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * 5 + p + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(8);
                    make.bottom.mas_equalTo(label1.mas_top).with.offset(-3);
                    
                }];
            }
        }
        else
        {
            NSArray *array = @[@"跌停",@">7%",@"7~5%",@"5~2%",@"2~0%"];
            for (int j = 0; j < 5; j++) {
                
                
                UILabel *label0 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:7] text:array[j] textColor:array7[i]];
                [self.view addSubview:label0];
                [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * 6 + p + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(10);
                    make.top.mas_equalTo(imageView2.mas_bottom).with.offset(61);
                    
                }];
                
                
                UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:9] text:@"" textColor:array7[i]];
                label1.backgroundColor = array7[i];
                [self.view addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16  + (24 + p) * 6 + p + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(30);
                    make.bottom.mas_equalTo(imageView2.mas_bottom).with.offset(58);
                    
                }];
                
                
                UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:9] text:@"23%" textColor:array7[i]];
                [self.view addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.view.mas_left).with.offset(16 + (24 + p) * 6 + p + (24 + p) * j);
                    make.width.mas_equalTo(24);
                    make.height.mas_equalTo(8);
                    make.bottom.mas_equalTo(label1.mas_top).with.offset(-3);
                    
                }];
            }
        }
        
        
        
    }
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   self.tableView.backgroundColor = [UIColor whiteColor];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
   [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HQTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"HQTableViewCell"];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   [self.view addSubview:self.tableView];
   
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(top.mas_bottom).with.offset(282 + 10);
       make.bottom.mas_equalTo(self.view.mas_bottom).offset(-self.tabBarController.tabBar.height);
       make.left.mas_equalTo(self.view.mas_left).with.offset(0);
       make.right.mas_equalTo(self.view.mas_right).with.offset(0);
       
   }];
    
    self.page = 1;
    
    self.type = 4;
    
    self.dataSource = @[].mutableCopy;
 
    [self setHeaderRefresh];
    [self setFooterRefresh];
    
    self.noDataLb = [[UILabel alloc] init];
    self.noDataLb.font = [UIFont systemFontOfSize:20];
    self.noDataLb.text = @"暂无数据";
    self.noDataLb.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:self.noDataLb];
    
    [self.noDataLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.mas_equalTo(self.tableView);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(250);
    }];
    
//    
//    MacVC *vc2 = [[MacVC alloc] initWithHeight:(self.bottomLineIV.maxY - self.topLineIV.y)];
//    [self addChildViewController:vc2];
//      
//    vc2.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,(self.bottomLineIV.maxY - self.topLineIV.y));
//    [self.view addSubview:vc2.view];
    
    [self getIndex];
}

- (void)getIndex{
    
 
    [[StockRequetServer sharedStockRequetServer] getStockSingleByCode:@"" type:@0 stockMarket:Shanghai success:^(id stockSingle) {
        
        IndexVO *indexVO = (IndexVO *)stockSingle;
        self.indexLbs[0].text = indexVO.nowpri;
        self.changeAmountLbs[0].text = indexVO.increase;
        self.changePercentageLbs[0].text = [NSString stringWithFormat:@"%@%%",indexVO.increPer];
        
    } failure:^(NSString *msg) {
        
         [self showToast:msg];
    }];
    
    [[StockRequetServer sharedStockRequetServer] getStockSingleByCode:@"" type:@1 stockMarket:Shanghai success:^(id stockSingle) {
           
           IndexVO *indexVO = (IndexVO *)stockSingle;
           self.indexLbs[1].text = indexVO.nowpri;
           self.changeAmountLbs[1].text = indexVO.increase;
           self.changePercentageLbs[1].text = [NSString stringWithFormat:@"%@%%",indexVO.increPer];
           
    } failure:^(NSString *msg) {
           
           [self showToast:msg];
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
        
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)czBtnCliked:(UIButton *)sender
{
    ZFPMViewController *vc = [[ZFPMViewController alloc]init];
    vc.dataSource = self.dataSource;
    StockMarket market = Shanghai;
      if (self.leftSelect == 0) {
          
          market = Shanghai;
      }else if (self.leftSelect == 1){
       
          market = HongKong;
      }else{
       
          market = USA;
      }
    vc.market = market;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    NSArray *array = @[@"    名称",@"最新单价",@"涨幅    "];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:11] text:array[i] textColor:[UIColor colorWithHexString:@"#DB36A4" alpha:1]];
        label2.frame = CGRectMake(16 + (Uni_kMainScreenWidth - 32) / 3 * i, 0, (Uni_kMainScreenWidth - 32) / 3, 22);
        
        if (i == 0) {
            label2.textAlignment = NSTextAlignmentLeft;
        }
        else if (i == 1) {
            label2.textAlignment = NSTextAlignmentCenter;
        }
        else
        {
            label2.textAlignment = NSTextAlignmentRight;
        }
        
        
        [view addSubview:label2];
        
    }
          
    return view;
     
    
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
    
    static NSString *identifier = @"HQTableViewCell";
    HQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[HQTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
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
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"no_image");
}


/**
 下拉刷新
 */
- (void)setHeaderRefresh{
 
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新..." forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = header;
    
   
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 上拉加载
 */
- (void)setFooterRefresh{
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    footer.stateLabel.textColor = [UIColor clearColor];
    footer.refreshingTitleHidden = YES;
    footer.activityIndicatorViewStyle = 1;
    footer.stateLabel.textColor = [UIColor whiteColor];;
    [footer setTitle:@"上拉加载数据..." forState:MJRefreshStateIdle];
    [footer setTitle:@"松开加载数据..." forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];

    self.tableView.mj_footer = footer;
}

/**
 上拉加载结束
 */
- (void)footerRefresh{
   
    self.page ++;
    //加载数据
    [self loadTableDataFromServer];
}
- (void)headerRefresh{
    
    self.page = 1;
    self.tableView.mj_footer.hidden = NO;
    [self.dataSource removeAllObjects];
    [self loadTableDataFromServer];
}
-(void)loadTableDataFromServer{
    
    StockMarket market = Shanghai;
    if (self.leftSelect == 0) {
        
        market = Shanghai;
    }else if (self.leftSelect == 1){
     
        market = HongKong;
    }else{
     
        market = USA;
    }
    
    [[StockRequetServer sharedStockRequetServer] getStockListByPage:self.page type:self.type stockMarket:market success:^(NSArray<DataList *> *stockList) {
        
        [self.tableView.mj_header endRefreshing];
        [self.dataSource addObjectsFromArray:stockList];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"!(changepercent contains '-')"];
        NSPredicate* downPredicate = [NSPredicate predicateWithFormat:@"changepercent contains '-'"];
        
        NSArray <DataList *>*tempArr = [self.dataSource filteredArrayUsingPredicate:predicate];
        NSArray <DataList *>*downList = [self.dataSource filteredArrayUsingPredicate:downPredicate];
        NSArray *resultList = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
           
            DataList *data1 = (DataList *)obj1;
            DataList *data2 = (DataList *)obj2;
            
            return [@(data2.changepercent.doubleValue) compare:@(data1.changepercent.doubleValue)];
            
            
        }];
        
        NSArray *downResultList = [downList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
           
            DataList *data1 = (DataList *)obj1;
            DataList *data2 = (DataList *)obj2;
            
            return [@(data2.changepercent.doubleValue) compare:@(data1.changepercent.doubleValue)];
            
            
        }];
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:resultList];
        [self.dataSource addObjectsFromArray:downResultList];

        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:self.dataSource];
        
        if (self.dataSource && self.dataSource.count > 0) {
            
            self.noDataLb.hidden = YES;
        }else{
         
            self.noDataLb.hidden = NO;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSString *msg) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showToast:msg];
    }];
}


/**
 *  显示提示消息
 */
- (void)showToast:(NSString *)msg{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.margin = 10.f;
    //hud.offset = CGP
    hud.offset = CGPointMake(hud.offset.x, Uni_kMainScreenHeight * 0.333);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
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

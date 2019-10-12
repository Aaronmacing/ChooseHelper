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
#import "YKLineChart.h"
@interface BuysellViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,YKLineChartViewDelegate>
@property(nonatomic,assign)NSInteger cbtnSelect;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *filePatch;
@property(nonatomic,copy)NSArray *array1;
@property(nonatomic,copy)NSArray *array2;
@property(nonatomic,copy)NSArray *array3;
@property(nonatomic,copy)NSArray *array4;
@property(nonatomic,copy)NSArray *array5;
@property(nonatomic,copy)NSArray *array6;
@property(nonatomic,assign)NSInteger nowNum;
@property(nonatomic,strong)NSMutableDictionary *nowData;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) YKLineChartView *klineView;

@end

@implementation BuysellViewController

- (instancetype)init
{
     self = [super init];
     if (self) {
          _model = [[StockSingleResultVO alloc]init];
     }
     return self;
}

- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     self.yuer = [user doubleForKey:@"canUse"];
     if (self.yuer == 0) {
         
         self.yuer = 10000;
     }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     
     DataSingle *model1 = self.model.data;
     
     if (self.type == 0) {
          
          self.titleLabel.text = [NSString stringWithFormat:@"卖出"];
     }
     else
     {
          self.titleLabel.text = [NSString stringWithFormat:@"买入"];
     }
     
     
     
     
     self.array1 = @[@"卖5",@"卖4",@"卖3",@"卖2",@"卖1"];
     self.array2 = @[model1.sellFivePri,model1.sellFourPri,model1.sellThreePri,model1.sellTwoPri,model1.sellOnePri];
     self.array3 = @[model1.sellFive,model1.sellFour,model1.sellThree,model1.sellTwo,model1.sellOne];
     
     self.array4 = @[@"买1",@"买2",@"买3",@"买4",@"买5"];
     self.array5 = @[model1.buyOnePri,model1.buyTwoPri,model1.buyThreePri,model1.buyFourPri,model1.buyFivePri];
     self.array6 = @[model1.buyOne,model1.buyTwo,model1.buyThree,model1.buyFour,model1.buyFive];
     
     
     
    
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
    
    UILabel *nameLabel = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15] text:[NSString stringWithFormat:@"%@-%@",model1.name,[model1.gid uppercaseString]] textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
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
        
        UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15] text:@"0" textColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1]];
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
     imageView.userInteractionEnabled = YES;
     [self.view addSubview:imageView];
     
     
      self.klineView = [[YKLineChartView alloc] init];
       [imageView addSubview:self.klineView];
       self.klineView.delegate = self;
       [self.klineView mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.top.left.bottom.right.mas_equalTo(imageView);
           
       }];
       
       NSString * path =[[NSBundle mainBundle]pathForResource:@"data2.plist" ofType:nil];
       NSArray * sourceArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:[NSString stringWithFormat:@"data%u",(arc4random_uniform(2) + 1)]];
       NSMutableArray * stockData = [NSMutableArray array];
          for (NSDictionary * dic in sourceArray) {
              
              YKLineEntity * entity = [[YKLineEntity alloc]init];
              entity.high = [dic[@"high_px"] doubleValue];
              entity.open = [dic[@"open_px"] doubleValue];
              
              entity.low = [dic[@"low_px"] doubleValue];
              
              entity.close = [dic[@"close_px"] doubleValue];
              
              entity.date = @"";
              entity.ma5 = [dic[@"avg5"] doubleValue];
              entity.ma10 = [dic[@"avg10"] doubleValue];
              entity.ma20 = [dic[@"avg20"] doubleValue];
              entity.volume = [dic[@"total_volume_trade"] doubleValue];
              [stockData addObject:entity];
              //YTimeLineEntity * entity = [[YTimeLineEntity alloc]init];
          }
          [stockData addObjectsFromArray:stockData];
          YKLineDataSet * dataset = [[YKLineDataSet alloc]init];
          dataset.data = stockData;
          dataset.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
          dataset.highlightLineWidth = 0.7;
          dataset.candleRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
          dataset.candleFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
          dataset.avgLineWidth = 1.f;
          dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];
          dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];
          dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];
          dataset.candleTopBottmLineWidth = 1;
          
          [self.klineView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
          self.klineView.gridBackgroundColor = [UIColor whiteColor];
          self.klineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
          self.klineView.borderWidth = .5;
          self.klineView.candleWidth = 8;
          self.klineView.candleMaxWidth = 30;
          self.klineView.candleMinWidth = 1;
          self.klineView.uperChartHeightScale = 0.7;
          self.klineView.xAxisHeitht = 25;
          self.klineView.delegate = self;
          self.klineView.highlightLineShowEnabled = YES;
          self.klineView.zoomEnabled = YES;
          self.klineView.scrollEnabled = YES;
          [self.klineView setupData:dataset];
     
     
     
     [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(top.mas_bottom).with.offset(10);
         make.height.mas_equalTo(224);
         make.left.mas_equalTo(self.view.mas_left).with.offset(0);
         make.right.mas_equalTo(self.view.mas_right).with.offset(0);
         
     }];
     
     
     UILabel *mLabel = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:12] text:[NSString stringWithFormat:@"账户余额:%0.2f",self.yuer] textColor:[UIColor whiteColor]];
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
     
     
     UILabel *label = [self.view viewWithTag:10];
     if (self.type == 1) {
      
          label.text = model1.buyOnePri;
     }
     else
     {
          label.text = model1.sellFivePri;
     }
     
//     UIButton *back = [UIButton new];
//     [back setImage:kGetImage(@"refreSh") forState:UIControlStateNormal];
//     [back addTarget:self action:@selector(refreShBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
//     [self.view addSubview:back];
//     [back mas_makeConstraints:^(MASConstraintMaker *make) {
//
//         make.top.mas_equalTo(self.view.mas_top).with.offset( HEIGHT_STATUSBAR);
//         make.width.mas_equalTo(44);
//         make.height.mas_equalTo(44);
//         make.right.mas_equalTo(self.view.mas_right);
//
//     }];
        
     self.cbtnSelect = 10;
     
     [self readData];
     
}

- (void)readData
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    self.filePatch = [path stringByAppendingPathComponent:@"info.plist"];//没有会自动创建
    
    NSMutableArray *sandBoxDataArray = [[NSMutableArray alloc]initWithContentsOfFile:self.filePatch];
     
     self.dataSource = [[NSMutableArray alloc]init];
     [self.dataSource addObjectsFromArray:sandBoxDataArray];
     
     for (int i = 0; i < 5; i++) {
          NSMutableDictionary *dic = sandBoxDataArray[i];
          NSString *the = dic[@"id"];
          DataSingle *model1 = self.model.data;
          if ([the isEqualToString:model1.gid]) {
               
               self.nowData = [[NSMutableDictionary alloc]initWithDictionary:dic];
               self.nowNum = i;
               break;
               
          }
          
     }
}




- (void)refreShBtnCliked:(UIButton *)sender
{
     
}

- (void)jbtnCliked:(UIButton *)sender
{
    UILabel *label = [self.view viewWithTag:sender.tag - 10];
    
    if (sender.tag - 20 == 0) {
    
        if([label.text doubleValue] <= 0.01)
        {
        }
         else
         {
              label.text = [NSString stringWithFormat:@"%0.2f",[label.text doubleValue] - 0.01];
         }
    }
    else
    {
         if([label.text doubleValue] <= 0)
         {
              
         }
         else
         {
              label.text = [NSString stringWithFormat:@"%0.0f",[label.text doubleValue] - 1];
         }
    }
    
}

- (void)addBtnClike:(UIButton *)sender
{
    UILabel *label = [self.view viewWithTag:sender.tag - 20];
    
    if (sender.tag - 30 == 0) {
    
        label.text = [NSString stringWithFormat:@"%0.2f",[label.text doubleValue] + 0.01];
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
        
        if (_cbtnSelect < 10) {
            
            UIButton *btn = [self.view viewWithTag:self.cbtnSelect + 40];
            btn.selected = NO;
             
             
             
        }
        
        
    }
    self.cbtnSelect = sender.tag - 40;
}

- (void)buyAndSellBtnCliked:(UIButton *)sender
{
     UILabel *label1 = [self.view viewWithTag:10];
     UILabel *label2 = [self.view viewWithTag:11];
      DataSingle *model1 = self.model.data;
     if (self.type == 0) {
          
          if (self.cbtnSelect >= 10) {
               
               if ([self.nowData[@"num"] intValue] <= [label2.text intValue] ) {
                    
                    [MBProgressHUD showError:@"没有足够的股票!"];
               }
               else
               {
                    if ([label1.text doubleValue] > [model1.sellFivePri doubleValue] ) {
                         
                         [MBProgressHUD showError:@"出售价格过高!"];
                    }
                    else
                    {
                         //出售中
                         NSString *now = [NSString stringWithFormat:@"%d",[self.nowData[@"num"]  intValue] - [label2.text intValue]];
                         
                         [self.nowData setObject:now forKey:@"num"];
                         
                         
                         double yuer = self.yuer + [label2.text intValue] * [label1.text doubleValue];
                         
                         NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                         [user setDouble:yuer forKey:@"canUse"];
                         [user synchronize];
                         
                         
                         [self.dataSource replaceObjectAtIndex:self.nowNum withObject:self.nowData];
                         [self.dataSource writeToFile:self.filePatch atomically:YES];
                         
                         [self saveMessgeWithNum:[label2.text intValue] price:[label1.text doubleValue]];
                         
                    }
               }
          }
          else
          {
               if ([self.nowData[@"num"] intValue] <= 0 ) {
                    
                    [MBProgressHUD showError:@"没有足够的股票!"];
               }
               else
               {
                    if ([label1.text doubleValue] > [model1.sellFivePri doubleValue] ) {
                         
                         [MBProgressHUD showError:@"出售价格过高!"];
                    }
                    else
                    {
                         int total = [self.nowData[@"num"]  intValue] -  ([self.nowData[@"num"]  intValue]) / (1 + self.cbtnSelect);
                         
                         //出售中
                         NSString *now = [NSString stringWithFormat:@"%d",total];
                         
                         [self.nowData setObject:now forKey:@"num"];
                         
                         
               
                         double add = self.yuer +  total * [label1.text doubleValue];
                         
                         NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                         [user setDouble:add forKey:@"canUse"];
                         [user synchronize];
                         
                         [self.dataSource replaceObjectAtIndex:self.nowNum withObject:self.nowData];
                         [self.dataSource writeToFile:self.filePatch atomically:YES];
                         
                         
                         [self saveMessgeWithNum:total price:[label1.text doubleValue]];
                    }
               }
          }
     }
     else
     {
          if (self.cbtnSelect >= 10) {
               
               if ([label2.text intValue] * [label1.text doubleValue] > self.yuer ) {
                    
                    [MBProgressHUD showError:@"没有足够的资金!"];
               }
               else
               {
                    if ([label1.text doubleValue] < [model1.buyOnePri doubleValue] ) {
                         
                         [MBProgressHUD showError:@"购买价格过低!"];
                    }
                    else
                    {
                         //买入后
                         NSString *now = [NSString stringWithFormat:@"%d",[self.nowData[@"num"]  intValue] + [label2.text intValue]];
                         
                         [self.nowData setObject:now forKey:@"num"];
                         
                         //余额
                         double add = self.yuer -  [label2.text intValue] * [label1.text doubleValue];
                         
                         NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                         [user setDouble:add forKey:@"canUse"];
                         [user synchronize];
                         
                         [self.dataSource replaceObjectAtIndex:self.nowNum withObject:self.nowData];
                         [self.dataSource writeToFile:self.filePatch atomically:YES];
                         
                         
                         [self saveMessgeWithNum:[label2.text intValue] price:[label1.text doubleValue]];
                         
                    }
               }
          }
          else
          {

                    if ([label1.text doubleValue] < [model1.buyOnePri doubleValue] ) {
                         
                         [MBProgressHUD showError:@"购买价格过低!"];
                    }
                    else
                    {
                         
                         
                         //买的入量
                         int total = self.yuer / [label1.text doubleValue] / (1 + self.cbtnSelect);
                         
                         //出售中
                         NSString *now = [NSString stringWithFormat:@"%d",[self.nowData[@"num"]  intValue] +  total];
                         
                         [self.nowData setObject:now forKey:@"num"];
                         [self.nowData setObject:label1.text forKey:@"price"];
                         

                         double add = self.yuer - total * [label1.text doubleValue];
                         
                         NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                         [user setDouble:add forKey:@"canUse"];
                         [user synchronize];
                         
                         [self.dataSource replaceObjectAtIndex:self.nowNum withObject:self.nowData];
                         [self.dataSource writeToFile:self.filePatch atomically:YES];
                         
                         [self saveMessgeWithNum:total price:[label1.text doubleValue]];
                    }
               
          }
     }
}


- (void)saveMessgeWithNum:(int)num price:(double)price
{
     NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *path = [pathArray objectAtIndex:0];
     //获取文件的完整路径
     NSString *filePatch = [path stringByAppendingPathComponent:@"Data.plist"];//没有会自动创建
     
     NSMutableArray *sandBoxDataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePatch];
     if (sandBoxDataArray == nil) {
          sandBoxDataArray = [[NSMutableArray alloc]init];
     }
     
     NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
     
     DataSingle *model1 = self.model.data;
     
     
     [dic setObject:[NSString stringWithFormat:@"%@-%@",model1.name,[model1.gid uppercaseString]] forKey:@"name"];
     [dic setObject:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
     [dic setObject:[NSString stringWithFormat:@"%0.2f",price] forKey:@"price"];
     [dic setObject:@(self.type) forKey:@"type"];
     
     [dic setObject:[self stringFromDate:[NSDate date]] forKey:@"time"];
     
     
     [sandBoxDataArray insertObject:dic atIndex:0];
     [sandBoxDataArray writeToFile:filePatch atomically:YES];
     
     [self.navigationController popViewControllerAnimated:YES];
     
}


 - (NSString*)stringFromDate:(NSDate*)date

{
     NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

   NSString *currentDateString=[dateFormatter stringFromDate:date];

     return currentDateString;

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

     if (indexPath.section == 0) {
          
          cell.firstLabel.text = self.array1[indexPath.row];
          cell.secondLabel.text = self.array2[indexPath.row];
          cell.thirdLabel.text = self.array3[indexPath.row];
     }
     else
     {
          cell.firstLabel.text = self.array4[indexPath.row];
          cell.secondLabel.text = self.array5[indexPath.row];
          cell.thirdLabel.text = self.array6[indexPath.row];
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
-(void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex
{
    
}

- (void)chartValueNothingSelected:(YKViewBase *)chartView
{
}

- (void)chartKlineScrollLeft:(YKViewBase *)chartView
{
    
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

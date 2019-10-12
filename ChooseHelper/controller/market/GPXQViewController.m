//
//  GPXQViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "GPXQViewController.h"
#import "BuysellViewController.h"
#import "StockRequetServer.h"
#import "YKLineChart.h"
@interface GPXQViewController ()<YKLineChartViewDelegate>
@property(nonatomic,assign)NSInteger leftSelect;

@property (nonatomic,strong) UILabel *nameLb;

@property (nonatomic,strong) UILabel *codeLb;

@property (nonatomic,strong) UILabel *priceLb;


/// 涨跌额 涨跌幅
@property (nonatomic,strong) UILabel *changeLb;


/// 值 labels
@property (nonatomic,strong) NSMutableArray <UILabel *>*valueLbs;

@property (nonatomic,strong) YKLineChartView *klineView;


@end

@implementation GPXQViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _model = [[StockSingleResultVO alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"股票详情";
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:@"西部资源" textColor:[UIColor colorWithHexString:@"#FF0004" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-100 + 200 * i);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(8);
            
        }];
        
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:9] text:@"+0.37 +0.37" textColor:[UIColor colorWithHexString:@"#FF0004" alpha:1]];
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(label1.mas_centerX);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(9);
            make.top.mas_equalTo(label1.mas_bottom).with.offset(12);
            
        }];
        
        if (i == 0) {
            
            self.nameLb = label1;
            self.codeLb = label2;
        }else{
         
            self.priceLb = label1;
            self.changeLb = label2;
            
        }
        
    }
    
    NSArray *array = @[@"今开",@"昨收",@"最高",@"最低",@"成交量",@"成交额"];
    self.valueLbs = @[].mutableCopy;
    
    double p = (Uni_kMainScreenWidth - 34) / 3;
    for (int i = 0; i < 6; i++) {
        
        UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] text:array[i] textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view.mas_left).with.offset(17 + p * (i % 3));
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(62 + 28 * (i / 3));
            
        }];
        
        
        UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] text:@"10.8万手" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
        
        if (i == 0 || i == 2) {
            label2.textColor = [UIColor colorWithHexString:@"#FF0004" alpha:1];
        }
        else if (i == 1 || i == 3) {
            label2.textColor = [UIColor colorWithHexString:@"#0A900A" alpha:1];
        }
        
        [self.view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(label1.mas_centerY);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(label1.mas_right).with.offset(10);
            
        }];
        [self.valueLbs addObject:label2];
    }
    

    UIImageView *fgx = [UIImageView new];
    fgx.image = kGetImage(@"gpxqfgx");
    [self.view addSubview:fgx];
    [fgx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(Uni_kMainScreenWidth);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(111);
    }];
    
    self.klineView = [[YKLineChartView alloc] init];
    [self.view addSubview:self.klineView];
    self.klineView.delegate = self;
    [self.klineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(fgx.mas_bottom).offset(5);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(300);
        
    }];
    
    
    NSString * path =[[NSBundle mainBundle]pathForResource:@"data.plist" ofType:nil];
    NSArray * sourceArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:[NSString stringWithFormat:@"data%u",(arc4random_uniform(4) + 1)]];
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
    
 
    if (self.type == 0) {
     
        UIButton *aBtn = [UIButton new];
        [aBtn addTarget:self action:@selector(cpBtnClied:) forControlEvents:UIControlEventTouchUpInside];
        [aBtn setBackgroundImage:kGetImage(@"adddelete") forState:UIControlStateNormal];
        [self.view addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(self.view.mas_left);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR);
            
            
        }];
    }
    else
    {
        UIButton *aBtn = [UIButton new];
        [aBtn addTarget:self action:@selector(dpBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [aBtn setBackgroundImage:kGetImage(@"buyin") forState:UIControlStateNormal];
        [self.view addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(108);
            make.height.mas_equalTo(49);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR);
            
            
        }];
        
        UIButton *bBtn = [UIButton new];
        [bBtn addTarget:self action:@selector(apBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        [bBtn setBackgroundImage:kGetImage(@"seelout") forState:UIControlStateNormal];
        [self.view addSubview:bBtn];
        [bBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(108);
            make.height.mas_equalTo(49);
            make.right.mas_equalTo(aBtn.mas_left);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(20 - HEIGHT_STATUSBAR);
            
            
        }];
    }
    
    [self getData];
}


- (void)getData{
    
 
    [[StockRequetServer sharedStockRequetServer] getStockSingleByCode:self.code type:nil stockMarket:self.market success:^(id stockSingle) {
       
        StockSingleResultVO *vo = (StockSingleResultVO *)stockSingle;
        
        self.nameLb.text = vo.data.name;
        self.codeLb.text = vo.data.gid;
        self.priceLb.text = vo.data.nowPri;
        self.changeLb.text = [NSString stringWithFormat:@"%@ %@%%",vo.data.increase,vo.data.increPer];
         
        //@"今开",@"昨收",@"最高",@"最低",@"成交量",@"成交额"
        self.valueLbs[0].text = vo.data.todayStartPri;
        self.valueLbs[1].text = vo.data.yestodEndPri;
        self.valueLbs[2].text = vo.data.todayMax;
        self.valueLbs[3].text = vo.data.todayMin;
        self.valueLbs[4].text = vo.data.traAmount;
        self.valueLbs[5].text = vo.data.traNumber;
    
    } failure:^(NSString *msg) {
        
    }];
}

- (void)cpBtnClied:(UIButton *)sender
{
    
}

- (void)dpBtnCliked:(UIButton *)sender
{
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)apBtnCliked:(UIButton *)sender
{
    BuysellViewController *vc = [[BuysellViewController alloc]init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
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
            make.bottom.mas_equalTo(sender.mas_bottom).with.offset(0);
        }];
    }
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

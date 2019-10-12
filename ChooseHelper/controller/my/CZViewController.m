//
//  CZViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CZViewController.h"
#import <StoreKit/StoreKit.h>

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

@interface CZViewController ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property(nonatomic,assign)NSInteger selectTag;
@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation CZViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = NO;
    self.titleLabel.text = @"账户充值";
    NSArray *array = @[@"￥68",@"￥108",@"￥158",@"￥198",@"￥258",@"￥308",@"￥388",@"￥488",@"￥588"];
    NSArray *array2 = @[@"送500金币",@"送1000金币",@"送2000金币"];
    for (int i = 0; i < 9; i++) {
        
        UIButton *czBtn = [UIButton new];
        czBtn.tag = 20 + i;
        [czBtn setBackgroundImage:kGetImage(@"2") forState:UIControlStateNormal];
        [czBtn setBackgroundImage:kGetImage(@"1") forState:UIControlStateSelected];
        [czBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [czBtn setTitleColor:[UIColor colorWithHexString:@"#0B70F4" alpha:1] forState:UIControlStateNormal];
        [czBtn setTitle:array[i] forState:UIControlStateNormal];
        [czBtn addTarget:self action:@selector(goToCZBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:czBtn];
        [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(71);
            make.height.mas_offset(39);
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-115 + 115 * (i % 3));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(24 + (39 + 17) * (i / 3));
            
        }];
        
        if (i == 0) {
            czBtn.selected = YES;
        }
        
        if ( (i  + 1) % 3 == 0) {
            
            UIButton *aBtn = [UIButton new];
            [aBtn setBackgroundImage:kGetImage(@"3") forState:UIControlStateNormal];
            [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [aBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
            [aBtn setTitle:array2[(i + 1) / 3 - 1] forState:UIControlStateNormal];
            [self.view addSubview:aBtn];
            [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.width.mas_equalTo(63);
                make.height.mas_offset(13);
                make.right.mas_equalTo(czBtn.mas_right);
                make.top.mas_equalTo(czBtn.mas_top).with.offset(-8);
                
            }];
        }
        
        
        
    }
    
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:13] text:@"到账金币数量：" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-115);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(207);
        
    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:13] text:@"6800" textColor:[UIColor colorWithHexString:@"#041833" alpha:1]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(115);
               make.width.mas_equalTo(90);
               make.height.mas_equalTo(15);
               make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(207);
        
    }];
    self.numLabel = label2;
    
    UIButton *czBtn = [UIButton new];
    [czBtn setBackgroundImage:kGetImage(@"ljcz") forState:UIControlStateNormal];
    [czBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:czBtn];
    [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(154);
        make.height.mas_offset(38);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(27);

    }];
    [self restoreProduct];

}

- (void)goToCZBtn:(UIButton *)sender
{
    
    
    if (sender.tag - 20 == self.selectTag) {
        
    }
    else
    {
        sender.selected = !sender.selected;
        
        
        UIButton *btn = [self.view viewWithTag:20 + self.selectTag];
        btn.selected = NO;
        self.selectTag = sender.tag - 20;
        
        NSArray *array = @[@"6800",@"10800",@"16300",@"19800",@"25800",@"31800",@"38800",@"48800",@"60300"];
        
        self.numLabel.text = array[self.selectTag];
        
        
    }
}


- (void)requestProducts
{
    NSArray *productIDs = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    // 2.向苹果发送请求，请求所有可买的商品
    //   2.1.创建请求对象
    NSSet *sets = [NSSet setWithArray:@[productIDs[self.selectTag]]];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:sets];
    
    //   2.2.设置代理
    request.delegate = self;
    
    //   2.3.开始请求
    [request start];
}

- (void)nextStep
{
    if ([SKPaymentQueue canMakePayments]) {
        
        
        [self requestProducts];
        
    }
    else
    {
        [MBProgressHUD showError:@"不支持苹果支付"];
    }
}


#pragma mark---------SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"%ld",response.products.count);
    
    //取到内购产品进行购买
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:response.products.firstObject];
    NSArray* transactions = [SKPaymentQueue defaultQueue].transactions;
    if (transactions.count > 0) {
        //检测是否有未完成的交易
        SKPaymentTransaction* transaction = [transactions firstObject];
        if (transaction.transactionState == SKPaymentTransactionStatePurchased) {
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            return;
        }
    }
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
    
    
    
    
//    // 1.对数组中对象进行排序（根据商品价格排序）
//    NSArray *products = [response.products sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(SKProduct *obj1, SKProduct *obj2) {
//        return [obj1.price compare:obj2.price];
//    }];
//
//    [self.dataSource addObjectsFromArray:products];
}


//交易结束
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    NSLog(@"交易结束");
    
}


#pragma mark - 实现观察者协议中的方法,来监听交易的变化
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    /*
     SKPaymentTransactionStatePurchasing,    正在购买
     SKPaymentTransactionStatePurchased,     购买成功
     SKPaymentTransactionStateFailed,        购买失败
     SKPaymentTransactionStateRestored,      恢复购买
     SKPaymentTransactionStateDeferred       最终状态未决定,交易依然在队列中
     */
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"正在购买商品");
                break;
                
            case SKPaymentTransactionStatePurchased:
                NSLog(@"购买成功.给用户对应商品");
                // 交易移除
                [queue finishTransaction:transaction];
                [self verifyPurchaseWithPaymentTransaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"购买失败");
                [queue finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateRestored:
                NSLog(@"恢复购买");
                [queue finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateDeferred:
                NSLog(@"未决定状态");
                break;
            default:
                break;
        }
    }
}


/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
-(void)verifyPurchaseWithPaymentTransaction{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];

    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串

    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];


    //创建请求到苹果官方进行购买验证
    NSURL *storeURL;
    #ifdef DEBUG
        storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    #else
        storeURL = [NSURL URLWithString:@"https://buy.itunes.apple.com/verifyReceipt"];
    #endif
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:storeURL];
    requestM.HTTPBody=bodyData;
    requestM.HTTPMethod=@"POST";
    //创建连接并发送同步请求
    NSError *error=nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
    if (error) {
        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dic);
    if([dic[@"status"] intValue]==0){
        NSLog(@"购买成功！");
        NSDictionary *dicReceipt= dic[@"receipt"];
        NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
        NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
        //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if ([productIdentifier isEqualToString:@"123"]) {
            NSInteger purchasedCount=[defaults integerForKey:productIdentifier];//已购买数量
            [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
        }else{
            [defaults setBool:YES forKey:productIdentifier];
        }
        //在此处对购买记录进行存储，可以存储到开发商的服务器端
        //成功处理
        
        [self successfulAction];
        
    }else{
        NSLog(@"购买失败，未通过验证！");
    }
}

//充值成功
-(void)successfulAction{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //写入数据库
        
        
    });
    
}


// 恢复购买
- (void)restoreProduct
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
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

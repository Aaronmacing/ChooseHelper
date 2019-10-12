//
//  GPXQViewController.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "StockRequetServer.h"
NS_ASSUME_NONNULL_BEGIN

@interface GPXQViewController : BaseViewController
@property(nonatomic,assign)NSInteger type;

/// 股票代码
@property (nonatomic,copy) NSString *code;

/// 股票市场
@property (nonatomic,assign) StockMarket market;
@end

NS_ASSUME_NONNULL_END

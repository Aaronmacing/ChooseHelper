//
//  ZFPMViewController.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "StockRequetServer.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZFPMViewController : BaseViewController

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,assign) StockMarket market;


@end

NS_ASSUME_NONNULL_END

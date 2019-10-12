//
//  GPXQViewController.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "StockSingleResultVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPXQViewController : BaseViewController
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)StockSingleResultVO *model;
@end

NS_ASSUME_NONNULL_END

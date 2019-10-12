//
//  NewgpTableViewCell.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockListResultVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewgpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (nonatomic, strong) DataList * dataVO;

@end

NS_ASSUME_NONNULL_END

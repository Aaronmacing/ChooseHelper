//
//  HQTableViewCell.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockListResultVO.h"
NS_ASSUME_NONNULL_BEGIN

@interface HQTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *zfLabel;

@property (nonatomic,strong) DataList *dataVO;

@end

NS_ASSUME_NONNULL_END

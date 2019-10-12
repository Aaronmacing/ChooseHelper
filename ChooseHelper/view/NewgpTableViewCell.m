//
//  NewgpTableViewCell.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NewgpTableViewCell.h"

@implementation NewgpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataVO:(DataList *)dataVO{
    
    _dataVO = dataVO;

    self.timeLabel.text = _dataVO.ticktime;
    self.nameLabel.text = _dataVO.name;
    self.priceLabel.text = _dataVO.trade;
    self.totalLabel.text = _dataVO.amount;
    self.weekLabel.text = @"";
    self.numLabel.text = _dataVO.volume;
    
}
@end

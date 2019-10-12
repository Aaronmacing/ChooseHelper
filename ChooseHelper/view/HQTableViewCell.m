//
//  HQTableViewCell.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HQTableViewCell.h"

@implementation HQTableViewCell

- (void)setDataVO:(DataList *)dataVO{
    
    _dataVO = dataVO;
    
    self.nameLabel.text = _dataVO.name;
    self.numLabel.text = _dataVO.symbol;
    self.priceLabel.text = _dataVO.trade;
    NSString *changeP = _dataVO.changepercent;
    if ([changeP containsString:@"-"]) {

         self.zfLabel.textColor = [UIColor greenColor];
     }else{

         self.zfLabel.textColor = [UIColor redColor];
     }
    self.zfLabel.text = [NSString stringWithFormat:@"%@%%",changeP];
}

@end

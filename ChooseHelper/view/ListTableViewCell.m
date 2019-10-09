//
//  ListTableViewCell.m
//  MathGame
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

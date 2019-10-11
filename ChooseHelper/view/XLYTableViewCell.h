//
//  XLYTableViewCell.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasLabel;
@property (weak, nonatomic) IBOutlet UILabel *cwLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *butBtn;
@property (weak, nonatomic) IBOutlet UIButton *sellBtn;
@property (weak, nonatomic) IBOutlet UIButton *hqBtn;

@end

NS_ASSUME_NONNULL_END

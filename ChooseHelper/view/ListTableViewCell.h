//
//  ListTableViewCell.h
//  MathGame
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

NS_ASSUME_NONNULL_END

//
//  BaseViewController.h
//  trafficRecord
//
//  Created by Apple on 2019/7/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *backImageView;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
- (void)backBtnCliked:(UIButton *)sender;
- (void)clearBtnCliked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END

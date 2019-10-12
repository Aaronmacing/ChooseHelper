//
//  BaseViewController.h
//  trafficRecord
//
//  Created by Apple on 2019/7/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountDao.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *backImageView;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong) Account *account;
- (void)backBtnCliked:(UIButton *)sender;
- (void)clearBtnCliked:(UIButton *)sender;

/**
 *  显示等待
 */
-(void)showWaiting;

/**
 *  隐藏等待
 */
-(void)dismissWaiting;

-(void)dismissWaitingWithShowToast:(NSString *)msg;

/**
 *  显示提示消息
 */
- (void)showToast:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END

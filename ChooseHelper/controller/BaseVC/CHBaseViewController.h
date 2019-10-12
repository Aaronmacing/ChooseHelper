//
//  BaseViewController.h
//  MyStock
//
//  Created by Company on 2019/10/10.
//  Copyright © 2019 CoooooY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppMacro.h"

#import "UIColor+AppColor.h"
#import "NSString+StringUtil.h"

#import "MBProgressHUD.h"

#import "UIView+Util.h"

#import "AccountDao.h"
/**
 基类
 */
@interface CHBaseViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>


/**
 导航栏
 */
@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic,strong) UIImageView *navIV;

/**
 导航栏左侧view
 */
@property (nonatomic, strong) UIView *leftView;

/**
 导航栏左侧view中的图标
 */
@property (nonatomic, strong) UIImageView *leftIV;

/**
 导航栏右侧view
 */
@property (nonatomic, strong) UIView *rightView;

/**
 导航栏右侧view中的图标
 */
@property (nonatomic, strong) UIImageView *rightIV;

/**
 导航栏右侧view中的标签
 */
@property (nonatomic, strong) UILabel *rightLabel;

/**
 导航栏标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 导航栏高度
 */
@property (assign, nonatomic)  CGFloat navigationHeight;

/**
 *  键盘弹出后View移动距离
 */
@property (nonatomic,assign) NSInteger movementDistance;

/**
 *  键盘高度
 */
@property (nonatomic,assign) CGFloat keyboardHeight;

/**
 *  当前view原始高度
 */
@property (nonatomic,assign) CGRect viewOriginalFrame;


@property (nonatomic,strong) UIImageView *bkIV;

@property (nonatomic,strong) Account *account;


/**
 *  初始化UI
 */
-(void)initUI;

/**
 *  初始化导航栏
 */
-(void)initNavigationBar;

/**
 设置背景颜色

 @param color 颜色
 */
- (void)setBackgroundColor:(UIColor *)color;

/**
 *  是否显示导航栏，默认显示
 */
- (BOOL)isShowNavigation;

/**
 *  点击导航栏左按钮
 */
- (void)clickLeft;


/**
 点击右侧
 */
- (void)clickRight;

/**
 *  显示对话框
 *
 *  @param string 对话框显示内容
 */
- (void)showAlert:(NSString *)string;


/**
 *  显示等待
 */
- (void)showWaiting;

/**
 *  隐藏等待
 */
- (void)dismissWaiting;

/**
 隐藏等待,并显示提示

 @param msg 提示
 */
- (void)dismissWaitingWithShowToast:(NSString *)msg;

/**
 显示提示消息

 @param msg 提示
 */
- (void)showToast:(NSString *)msg;

-(void)saveInfoByKey:(NSString *)key andValue:(NSObject *)value;

-(id)getInfoByKey:(NSString *)key;

@end

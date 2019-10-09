//
//  YCAlertView.h
//  YCAlertView
//
//  Created by zyc on 2017/11/1.
//  Copyright © 2017年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^OnCancleButtonClick)(void);
typedef void (^OnSureButtonClick)(id obj);


@interface YCAlertView : UIView

@property (nonatomic, copy) OnCancleButtonClick cancleBlock;
@property (nonatomic, copy) OnSureButtonClick sureBlock;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title confrimBolck:(void (^)(id obj))confrimBlock cancelBlock:(void (^)(void))cancelBlock;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title placeArray:(NSArray *)placeArray confrimBolck:(void (^)(id obj))confrimBlock cancelBlock:(void (^)(void))cancelBlock;

//弹出
-(void)show;

//隐藏
-(void)hide;

@end

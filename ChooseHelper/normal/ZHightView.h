//
//  ZZHDateView.h
//  XHJY_app
//
//  Created by zzh_iPhone on 16/3/9.
//  Copyright © 2016年 LiangXiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZHightView : UIView
/**
 *  返回的数据
 */
@property (nonatomic, copy) void(^calendarBlock)(NSInteger age);

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withDataSource:(NSArray *)array withSelectid:(NSInteger)num;
- (void)show;
- (void)hidden;
@end

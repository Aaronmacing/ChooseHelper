
#import <UIKit/UIKit.h>
#import "UITapGestureRecognizer+Property.h"
@interface UIView (Util)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;


/**
 *  添加点击事件
 *
 *  @param target target
 *  @param method 点击后调用方法
 */
- (void)addTarget:(id)target action:(SEL)method;

/**
 *  添加点击事件
 *
 *  @param target target
 *  @param method 点击后调用方法
 *  @param data   传递的数据
 */
-(void)addTarget:(id)target action:(SEL)method data:(id)data;

@end

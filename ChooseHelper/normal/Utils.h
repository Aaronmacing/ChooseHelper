//
//  Utils.h
//  Travelplan
//
//  Created by Apple on 2019/7/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject
+ (UILabel *)setLabelWithlines:(int)lines textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)Color;

+ (void)setInput;


+ (BOOL)createDirectoryAtPath:(NSString *)path;


+ (BOOL)Uni_isCNTimeZone;

+ (void)Uni_showAlertWithTitle:(NSString *)title message:(NSString *)message cancle:(NSString *)cTitle sure:(NSString *)sTitle viewController:(UIViewController *)controller handlerCompletion:(void(^)(NSInteger option))completion;

+ (UIImage *)getNvaImageWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

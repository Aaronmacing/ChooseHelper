//
//  UIImage+Additions.h
//  BabyRecord
//
//  Created by SuperBilllion on 2018/11/29.
//  Copyright © 2018 SuperBilllion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Additions)

+ (UIImage *)InitWithColor:(UIColor*)color rect:(CGRect)rect;
+ (UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr;

@end

NS_ASSUME_NONNULL_END

//
//  UIImage+Utils.h
//  Quit drinking
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utils)


+ (UIImage *)Tam_InitWithColor:(UIColor*)color rect:(CGRect)rect;

- (NSString *)ImageToBase64String;

+ (UIImage *)base64StringToImage:(NSString *)base64Str;
@end

NS_ASSUME_NONNULL_END

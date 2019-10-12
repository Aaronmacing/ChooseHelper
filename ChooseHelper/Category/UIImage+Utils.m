//
//  UIImage+Utils.m
//  Quit drinking
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)Tam_InitWithColor:(UIColor*)color rect:(CGRect)rect{
    CGRect imgRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    UIGraphicsBeginImageContextWithOptions(imgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imgRect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (NSString *)ImageToBase64String{
    
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    return encodedImageStr;
}

+ (UIImage *)base64StringToImage:(NSString *)base64Str{
    
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData: imageData];
    return decodedImage;
}

@end

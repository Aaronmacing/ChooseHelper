//
//  NSString+StringUtil.h
//  iOSBaseFramework
//
//  Created by WeiLin on 15/12/9.
//  Copyright © 2015年 LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StringUtil)

/**
 *  字符串转换成SHA1值
 *
 *  @return SHA即Secure Hash Algorithm（安全散列算法)
 */
- (NSString*) stringToSHA1;

/**
 *  字符串转换成MD5值
 *
 *  @return MD5即Message Digest Algorithm 5（信息-摘要算法 5）
 */
- (NSString *) stringToMD5;
/**
 *  字符串转换成Base64值
 *
 *  @return Base64字符串
 */
-(NSString *)stringToBase64;

/**
 *  字符串是否为空
 *  @"  " is YES
 *  @"" is YES
 *  nil is YES
 *  NULL is YES
 *  
 *  @param string 字符串
 *
 *  @return YES or NO
 */
+ (BOOL) isBlankString:(NSString *)string;

/**
 *  字符串是否不为空
 *
 *  @param string 字符串
 *
 *  @return YES or NO
 */
+ (BOOL) isNotBlankString:(NSString *)string;

/*  判断字符串是否包含B
 *
 *  @return YES OR NO
 */
- (BOOL)isContains:(NSString *)bStr;

/**
 *  给定宽度，字体，返回高度
 *
 *  @param width 固定宽度
 *  @param font  字体
 */
- (CGSize)sizeWithPreferWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  给定高度，字体，返回宽度
 *
 *  @param height 固定高度
 *  @param font  字体
 */
- (CGSize)sizeWithpreferHeight:(CGFloat)height font:(UIFont *)font;
/**
 * 判断是否是纯数字
 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;

/**
 格式化数字字符串

 @param str 字符串
 @param numberStyle 数字格式
 */
+ (NSString *)stringChangeMoneyWithStr:(NSString *)str numberStyle:(NSNumberFormatterStyle)numberStyle;
@end

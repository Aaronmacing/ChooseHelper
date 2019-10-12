//
//  NSString+StringUtil.m
//  iOSBaseFramework
//
//  Created by WeiLin on 15/12/9.
//  Copyright © 2015年 LIN. All rights reserved.
//

#import "NSString+StringUtil.h"
#import<CommonCrypto/CommonDigest.h>
@implementation NSString (StringUtil)

- (NSString*) stringToSHA1{
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

-(NSString *) stringToMD5{
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

-(NSString *)stringToBase64{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Decoded = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64Decoded;
}


+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    if ([string stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return YES;
    }

    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
    }
    return NO;
}

+ (BOOL) isNotBlankString:(NSString *)string {
    
    return ![self isBlankString:string];
}

- (BOOL)isContains:(NSString *)bStr{
    NSRange foundObj=[self rangeOfString:bStr options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        return YES;
    }
    return NO;
}
- (CGSize)sizeWithpreferHeight:(CGFloat)height font:(UIFont *)font{
    
    if (!font) {
        return CGSizeZero;
    }
    NSDictionary *dict=@{NSFontAttributeName : font};
    return [self sizeWithpreferHeight:height attribute:dict];
}

- (CGSize)sizeWithpreferHeight:(CGFloat)height attribute:(NSDictionary *)attr{
    
    CGRect rect=[self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                   options:(NSStringDrawingUsesLineFragmentOrigin)
                                attributes:attr context:nil];
    
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (CGSize)sizeWithPreferWidth:(CGFloat)width font:(UIFont *)font{
    
    if (!font) {
        
       return CGSizeZero;
    }
    NSDictionary *dict=@{NSFontAttributeName:font};
    return [self sizeWithPreferWidth:width attribute:dict];
}

- (CGSize)sizeWithPreferWidth:(CGFloat)width attribute:(NSDictionary *)attr{
    
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                   options:(NSStringDrawingUsesLineFragmentOrigin)
                                attributes:attr context:nil];
    
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

+ (BOOL)isPureNumandCharacters:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }
    return YES;
}
+ (NSString *)stringChangeMoneyWithStr:(NSString *)str numberStyle:(NSNumberFormatterStyle)numberStyle {
    
    // 判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || str == nil)) {
        str = 0;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = numberStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    
    return money;
}


@end

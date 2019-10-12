#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

//=============十六进制颜色转UIColor=============
/**
 RGBA十六进制转UIColor 若传RGB十六进制则默认Alpha为1 
 */
+ (UIColor *) colorFromRGBAHexCode:(NSString *)hexString {
    
    //去掉#号
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    //字符串转十六进制
    if([cleanString length] == 3) {
       
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    // 0xff，即二进制的1序列，比如11111111
    // (0xABCDEF & 0xFF0000 )>>16
    // (0xABCDEF & 0xFF00)>>8
    // 0xABCDEF & 0xFF
    // 分别拿到AB ，CD, EF位置的数值 即RGB中 red green blue的数值
    CGFloat red = ((baseValue >> 24) & 0xFF)/255.0f;
    CGFloat green = ((baseValue >> 16) & 0xFF)/255.0f;
    CGFloat blue = ((baseValue >> 8) & 0xFF)/255.0f;
    CGFloat alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
//=============十六进制颜色转UIColor end=============
@end

//
//  Utils.m
//  Travelplan
//
//  Created by Apple on 2019/7/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UILabel *)setLabelWithlines:(int)lines textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)Color
{
    UILabel *label1 = [UILabel new];
    label1.numberOfLines = lines;
    label1.textAlignment = textAlignment;
    label1.font = font;
    label1.text = text;
    label1.textColor = Color;
    return label1;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    NSArray *DocumentPath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",DocumentPath[0],path]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    if ([manager fileExistsAtPath:filepath isDirectory:&isDir]) {
        NSLog(@"file is exists");
        
        return YES;
    } else{
        
        NSError *error;
        BOOL isSuccess = [manager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:&error];
        return isSuccess;
    };
    
}

+ (void)setInput
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
//    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

+ (BOOL)Uni_isCNTimeZone{
    
    NSTimeZone * cTimeZone = [NSTimeZone systemTimeZone];
    // 获取语言
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if (([cTimeZone.name isEqualToString:@"Asia/Urumqi"] || [cTimeZone.abbreviation isEqualToString:@"GMT+8"] || [cTimeZone.name isEqualToString:@"Asia/Kashgar"])&& ([currentLanguage containsString:@"zh-Hant"] || [currentLanguage containsString:@"zh-Hans"])) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)Uni_showAlertWithTitle:(NSString *)title message:(NSString *)message cancle:(NSString *)cTitle sure:(NSString *)sTitle viewController:(UIViewController *)controller handlerCompletion:(void(^)(NSInteger option))completion{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert ];
    
    if (!Uni_isEmptyString(cTitle)) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(0);
            }
        }];
        [alertController addAction:cancelAction];
    }
    
    if (!Uni_isEmptyString(sTitle)) {
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:sTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(1);
            }
        }];
        [alertController addAction:OKAction];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}


+ (UIImage *)getNvaImageWithImage:(UIImage *)image{
    CGSize imageSize = CGSizeMake(Uni_kMainScreenWidth, Uni_kMainScreenHeight);
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

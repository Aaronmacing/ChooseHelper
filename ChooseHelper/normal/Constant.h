//
//  Constant.h
//  MathGame
//
//  Created by apple on 2019/5/15.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define Uni_isNull(x) (!x || [x isKindOfClass:[NSNull class]])
#define Uni_isEmptyString(x) (Uni_isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"] || [[x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#define Uni_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define Uni_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


#define HEIGHT_STATUSBAR [[UIApplication sharedApplication] statusBarFrame].size.height

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define HEIGHT_NAVBAR 44.f
#define Uni_NAVBAR_ALLHEIGHT (HEIGHT_STATUSBAR + HEIGHT_NAVBAR)
#define Uni_TABBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define Uni_kMainScreenHeight         [[UIScreen mainScreen] bounds].size.height
#define Uni_kMainScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define Uni_SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#endif /* Constant_h */

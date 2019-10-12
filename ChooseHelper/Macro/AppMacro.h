
//  APP常用宏

#ifndef AppMacro_h
#define AppMacro_h

//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define Tam_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Tam_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

//状态栏高度
#define Tam_NAV_HEIGHT (STATUS_HEIGHT + 44.0f)

#define Tam_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define Tam_isNull(x) (!x || [x isKindOfClass:[NSNull class]])
#define Tam_isEmptyString(x) (Tam_isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"] || [[x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

//1像素
#define ONE_PIXEL 1.0 / [UIScreen mainScreen].scale

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//大于等于11.0的ios版本
#define Tam_iOS11_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")

//判断是否是iPhone X
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define Tam_SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
//判断是否是iPhone 5 SE
#define KIsiPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//调试时打印log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...);
#define LOG_METHOD;
#endif


#endif /* AppMacro_h */

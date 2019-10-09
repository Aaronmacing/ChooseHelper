//
//  UIColor+TT.h
//  resistance
//
//  Created by Apple on 2019/5/30.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TT)
+(UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity;
@end

NS_ASSUME_NONNULL_END

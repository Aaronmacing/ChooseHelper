//
//  SignViewController.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignViewController : CHBaseViewController

@property (nonatomic, copy) void(^SucBack)(NSString *account,NSString *pwd);

@end

NS_ASSUME_NONNULL_END

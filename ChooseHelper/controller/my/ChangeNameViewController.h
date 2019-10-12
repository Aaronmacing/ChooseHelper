//
//  ChangeNameViewController.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangeNameViewController : BaseViewController

@property (nonatomic,copy) void (^changeName)(NSString *name);

@end

NS_ASSUME_NONNULL_END

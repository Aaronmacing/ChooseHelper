//
//  PlayViewController.h
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class KsModel;

@interface PlayViewController : BaseViewController
@property (nonatomic, strong) KsModel * vidModel;
@property (nonatomic, strong) NSArray * rArr;

@end

NS_ASSUME_NONNULL_END

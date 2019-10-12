//
//  StockNewsModel.h
//  MyStock
//
//  Created by apple on 2019/10/10.
//  Copyright © 2019 CoooooY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NewsInfoModel;

@interface StockNewsModel : NSObject

@property (nonatomic, copy) NSString * stat;
@property (nonatomic, strong) NSArray * data;

@end

@interface NewsInfoModel : NSObject

@property (nonatomic, copy) NSString * uniquekey;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * date;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * author_name;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * thumbnail_pic_s;
@property (nonatomic, copy) NSString * thumbnail_pic_s02;
@property (nonatomic, copy) NSString * thumbnail_pic_s03;

@end

NS_ASSUME_NONNULL_END

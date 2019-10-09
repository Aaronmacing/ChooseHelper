//
//  RequestResultVO.h
//  CloudMonitor
//
//  Created by WeiLin on 2017/12/5.
//  Copyright © 2017年 STS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Data,Info,Ext_Info;
@interface RequestResultVO : NSObject

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, strong) Data *data;

@property (nonatomic, copy) NSString *msg;

@end
@interface Data : NSObject

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@property (nonatomic,copy) NSString *uuid;

@property (nonatomic, strong) Info *info;

@property (nonatomic,copy) NSString *token;

@end

@interface Info : NSObject

@property (nonatomic, strong) Ext_Info *ext_info;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *register_ip;

@property (nonatomic, copy) NSString *rolename;

@property (nonatomic, copy) NSString *register_time;

@end

@interface Ext_Info : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nickName;

@end

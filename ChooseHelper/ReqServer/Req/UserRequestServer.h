//
//  UserRequestServer.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaseRequestServer.h"
#import "AccountDao.h"
#import <YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserRequestServer : BaseRequestServer

SingletonH(UserRequestServer)

- (void)loginWithAccount:(NSString *_Nonnull)account
                password:(NSString *_Nonnull)password
                success:(void (^)(Account *account))success
                failure:(void (^)(NSString *msg))failure;

- (void)singUpWithAccount:(NSString *_Nonnull)account
                password:(NSString *_Nonnull)password
                 success:(void (^)(void))success
                 failure:(void (^)(NSString *msg))failure;

- (void)loginOutWithUUID:(NSString *_Nonnull)uuid
                  success:(void (^)(void))success
                  failure:(void (^)(NSString *msg))failure;

- (void)changePWByAccount:(NSString *)account
                    oldPW:(NSString *)oldPW
                    newPW:(NSString *)newPW
                  success:(void (^)(void))success
                  failure:(void (^)(NSString *msg))failure;

- (void)changeUserInfoByUUID:(NSString *)uuid
                      avatar:(UIImage *)avatar
                        name:(NSString *)name
                     success:(void (^)(void))success
                     failure:(void (^)(NSString *msg))failure;

- (void)getUserInfoByAccount:(Account *)account
                  success:(void (^)(Account *account))success
                  failure:(void (^)(NSString *msg))failure;


@end

NS_ASSUME_NONNULL_END

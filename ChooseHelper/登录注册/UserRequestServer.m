//
//  UserRequestServer.m
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UserRequestServer.h"
#import "NSDictionary+NilSafe.h"
#import "UIImage+Utils.h"
@implementation UserRequestServer

SingletonM(UserRequestServer)

- (void)loginWithAccount:(NSString * _Nonnull)account
                password:(NSString * _Nonnull)password
                 success:(void (^)(Account * _Nonnull))success
                 failure:(void (^)(NSString * _Nonnull))failure{
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"username":account,@"password":[password stringToMD5].lowercaseString}];
    
    [self excuteWithUrl:URL_USER_LOGIN andParameter:parm andSuccess:^(Data *returnData) {
        
        Account *currentAC = [[Account alloc] init];
        currentAC.account = account;
        currentAC.name = currentAC.account;
        currentAC.isReadMsg = @0;
////        if ([[AccountDao sharedAccountDao] queryAccountByAccount:account]) {
////
////            currentAC = [[AccountDao sharedAccountDao] queryAccountByAccount:account];
////
////        }
//        currentAC.uuid = returnData.uuid;
//        currentAC.password = password;
//        //[[AccountDao sharedAccountDao] insertOrUpdateData:currentAC];
        
        success(currentAC);
    } andFailure:^(NSString *msg) {
        
        failure(msg);
    }];
}

- (void)singUpWithAccount:(NSString *)account
                 password:(NSString *)password
                  success:(void (^)(void))success
                  failure:(void (^)(NSString * _Nonnull))failure{
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"username":account,@"password":[password stringToMD5].lowercaseString}];
    
    [self excuteWithUrl:URL_USER_SIGN_UP andParameter:parm andSuccess:^(Data *returnData) {
        
        success();
    } andFailure:^(NSString *msg) {
        
        failure(msg);
    }];
}

- (void)loginOutWithUUID:(NSString *)uuid
                 success:(void (^)(void))success
                 failure:(void (^)(NSString * _Nonnull))failure{
    
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"uuid":uuid}];
    
    [self excuteWithUrl:URL_USER_LOGIN_OUT andParameter:parm andSuccess:^(Data *returnData) {
        
        success();
    } andFailure:^(NSString *msg) {
        
        failure(msg);
    }];
}

- (void)changePWByAccount:(NSString *)account
                    oldPW:(NSString *)oldPW
                    newPW:(NSString *)newPW
                  success:(void (^)(void))success
                  failure:(void (^)(NSString * _Nonnull))failure{
    
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"username":account,@"old_password":[oldPW stringToMD5].lowercaseString,@"new_password":[newPW stringToMD5].lowercaseString}];
    
    [self excuteWithUrl:URL_USER_CHANGE_PW andParameter:parm andSuccess:^(Data *returnData) {
        
        success();
    } andFailure:^(NSString *msg) {
        
        failure(msg);
    }];
}


- (void)changeUserInfoByUUID:(NSString *)uuid
                      avatar:(UIImage *)avatar
                        name:(NSString *)name
                     success:(void (^)(void))success
                     failure:(void (^)(NSString * _Nonnull))failure{
    
    
    NSDictionary *extDic = @{@"nickName":name,@"avatar":[avatar ImageToBase64String]};
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"uuid":uuid,@"ext_info":[extDic yy_modelToJSONString]}];
    
    [self excuteWithUrl:URL_USER_CHANGE_INFO andParameter:parm andSuccess:^(Data *returnData) {
        
        success();
    } andFailure:^(NSString *msg) {
        
        failure(msg);
    }];
}


- (void)getUserInfoByAccount:(Account *)account
                  success:(void (^)(Account * _Nonnull))success
                  failure:(void (^)(NSString * _Nonnull))failure{
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"uuid":account.uuid}];
    
    [self excuteWithUrl:URL_USER_GET_INFO andParameter:parm andSuccess:^(Data *returnData) {
        
        account.avatar = returnData.info.ext_info.avatar;
        account.name = returnData.info.ext_info.nickName;
        //[[AccountDao sharedAccountDao] insertOrUpdateData:account];
        
        success(account);
        
    } andFailure:^(NSString *msg) {
        
        failure(msg);
    }];
    
    
    
}

@end

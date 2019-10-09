//
//  UrlConst.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#ifndef UrlConst_h
#define UrlConst_h

/**
 服务器协议
 */
static NSString *const PROTOCOL = @"http://";

/**
 服务器IP
 */
static  NSString * const SERVER_IP = @"hn216.api.yesapi.cn/?s=";


/**
 服务器IP
 */
static  NSString * const STOCK_SERVER_IP = @"web.juhe.cn:8080/finance/stock/";

//---------------------------用户------start--------------------------------------------------------------------


/**
 注册
 */
static  NSString * const URL_USER_SIGN_UP = @"App.User.Register";

/**
 登录
 */
static  NSString * const URL_USER_LOGIN = @"App.User.Login";

/**
 退出登录
 */
static  NSString * const URL_USER_LOGIN_OUT = @"App.User.Logout";

/**
 修改密码
 */
static  NSString * const URL_USER_CHANGE_PW = @"App.User.AlterPassword";

/**
 获取个人信息
 */
static  NSString * const URL_USER_GET_INFO = @"App.User.Profile";

/**
 获取个人信息
 */
static  NSString * const URL_USER_CHANGE_INFO = @"App.User.UpdateExtInfo";


/**
 沪深个股
 */
static  NSString * const URL_STOCK_SHSS_SINGLE = @"hs";

/**
 香港个股
 */
static  NSString * const URL_STOCK_HK_SINGLE = @"hk";

/**
 美国个股
 */
static  NSString * const URL_STOCK_USA_SINGLE = @"usa";

/**
 沪股列表
 */
static  NSString * const URL_STOCK_SH_LIST = @"shall";

/**
 深股列表
 */
static  NSString * const URL_STOCK_SZ_LIST = @"szall";

/**
 香港列表
 */
static  NSString * const URL_STOCK_HK_LIST = @"hkall";

/**
 美国列表
 */
static  NSString * const URL_STOCK_USA_LIST = @"usaall";

#endif /* UrlConst_h */

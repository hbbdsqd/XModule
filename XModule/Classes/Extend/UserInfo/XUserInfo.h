//
//  XTool.h
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XUserInfo : NSObject

/// 登录成功回调
@property (nonatomic, copy) void(^loginSuccessBlock)(void);

/// 是否进入首页，默认：yes：进入首页、no，只是登录成功回调，只有当没有接受者时才进入首页。
@property (nonatomic,assign) BOOL canEnterHomeBool;

/// 单例
+ (instancetype)sharedInstance;

/// 清除用户信息
+ (void)clearUserInfo;

/// 退出登录状态
+ (void)logout;

/// 获取登录状态
+ (BOOL)checkLoginStatus; 

/// 校验需要登录的操作
/// @param loginSuccessBlock 登录成功回调
+ (void)needLoginSuccess:(void(^)(void))loginSuccessBlock;

/// 通知appdelegate登录状态改变，修改展示页面
+ (void)notiAppdelegateLoginStatusChanged;

/// 通知本类，登录成功，继续操作
+ (void)notiInfoManagerLoginSuccess;
@end

NS_ASSUME_NONNULL_END

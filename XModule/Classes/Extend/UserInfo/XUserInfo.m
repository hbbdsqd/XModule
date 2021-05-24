//
//  XTool.m
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import "XUserInfo.h"

@implementation XUserInfo

+ (instancetype)sharedInstance
{
    static XUserInfo * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        _sharedInstance.canEnterHomeBool = YES;
    });
    return _sharedInstance;
}

/// 清除用户信息
+ (void)clearUserInfo{
    
}

/// 退出登录状态
+ (void)logout{
    [self clearUserInfo];
    [self notiAppdelegateLoginStatusChanged];
}

/// 获取登录状态
+ (BOOL)checkLoginStatus{
    BOOL loginStatus = NO;
    loginStatus = YES;
    return loginStatus;
}

/// 校验需要登录的操作
/// @param loginSuccessBlock 登录成功回调
+ (void)needLoginSuccess:(void(^)(void))loginSuccessBlock{
    [XUserInfo sharedInstance].canEnterHomeBool = NO;
    if ([self checkLoginStatus]) {
        loginSuccessBlock();
    }else{
        [XUserInfo sharedInstance].loginSuccessBlock = loginSuccessBlock;
        Class c = NSClassFromString(@"FLLoginVerVC");
        XBaseViewController * vc = (XBaseViewController *)[[c alloc]init];
        XBaseNavigationController * nav = [[XBaseNavigationController alloc]initWithRootViewController:vc];
        nav.modalPresentationStyle = 0;
        [[XTool getcurController] presentViewController:nav animated:YES completion:nil];
    }
}

/// 通知appdelegate登录状态改变，修改展示页面
+ (void)notiAppdelegateLoginStatusChanged{
    [XUserInfo sharedInstance].canEnterHomeBool = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FLLoginStatusChanged" object:nil];
//    校验之前是否有需要跳转的路由，如果有接着跳，没有就只进首页
    NSString * linkUrlStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"linkUrlStr"];
    if (!FLStringIsEmpty(linkUrlStr) && [XUserInfo checkLoginStatus]) {
//        [[FLRouterManager sharedInstance] routerWithLinkUrlStr:linkUrlStr];
        Class class = NSClassFromString(@"FLRouterManager");
        if (class) {
            id obj = [[class alloc] init];
            SEL sel = NSSelectorFromString(@"routerWithLinkUrlStr:");
            IMP imp = [obj methodForSelector:sel];
            void (*func)(id, SEL, NSString *) = (void *)imp;
            func(obj, sel, linkUrlStr);
        }
    }
}

/// 通知本类，登录成功，继续操作
+ (void)notiInfoManagerLoginSuccess{
    if ([XUserInfo checkLoginStatus]) {
        if ([XUserInfo sharedInstance].canEnterHomeBool) {
            [XUserInfo notiAppdelegateLoginStatusChanged];
        }else{
            [[XTool getcurController].navigationController dismissViewControllerAnimated:YES completion:nil];
            [XUserInfo sharedInstance].loginSuccessBlock();
        }
    }else{
        [XUserInfo notiAppdelegateLoginStatusChanged];
    }
}

@end

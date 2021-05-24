//
//  XRouter.m
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import "XRouter.h"
#import "NSObject+MJClass.h"
#import "XUserInfo.h"

@implementation XRouter

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


/// 根据链接获取控制器并进行跳转
/// @param linkUrlStr fltrporganstudent://fltrp.com/words/enterController?classId=1&name=summer

- (void)routerWithLinkUrlStr:(NSString *)linkUrlStr{
    //    如果为空，不做处理
    if (FLStringIsEmpty(linkUrlStr)) {
        
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"linkUrlStr"];
        XUrlType type = [self getUrlType:linkUrlStr];
        if (type == XUrlTypeError) {
            
        }else if (type == XUrlTypeWeb){
//            UIViewController * vc = [[XRouter sharedInstance] gotoCommonWebVCWithUrlStr:linkUrlStr resultBlock:nil];
//            [(UIViewController *)vc setIsGetTitle:true];
//            [[XRouter getcurController].navigationController pushViewController:vc animated:YES];
        }else if (type == XUrlTypeNative){
            //        如果没有登录就跳转登录，登录了就跳转到指定页面
            if ([XUserInfo checkLoginStatus] && [self judgeRootVCIsTabbar]) {
                XBaseViewController * vc = [self loadVCData:linkUrlStr];
                if ([self judgeVCIfNeedJump:vc]) {
                    return;
                }
                if (!vc) {
                    XShowMessage(@"路由解析错误");
                    return;
                }
                [[XTool getcurController].navigationController pushViewController:vc animated:YES];
            }else{
                [[NSUserDefaults standardUserDefaults] setValue:linkUrlStr forKey:@"linkUrlStr"];
            }
        }
    }
}

/// 判断控制器是否是跟控制器，如果是跟控制器，只做切换tab操作
- (BOOL)judgeVCIfNeedJump:(UIViewController *)vc{
    BOOL isExist = NO;
    XBaseTabBarViewController * tabbarVC = (XBaseTabBarViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ([NSStringFromClass([vc class]) isEqual:@"FLlearningHomeVC"]) {
        tabbarVC.selectedIndex = 0;
        isExist = YES;
    }else if ([NSStringFromClass([vc class]) isEqual:@"FLSMineVC"]){
        tabbarVC.selectedIndex = 1;
        isExist = YES;
    }else if ([NSStringFromClass([vc class]) isEqual:@"FLTHomeMainVC"]){
        tabbarVC.selectedIndex = 0;
        isExist = YES;
    }else if ([NSStringFromClass([vc class]) isEqual:@"FLTClassMainVC"]){
        tabbarVC.selectedIndex = 1;
        isExist = YES;
    }else if ([NSStringFromClass([vc class]) isEqual:@"FLTMineMainVC"]){
        tabbarVC.selectedIndex = 2;
        isExist = YES;
    }
    return isExist;
}

/// 判断跟控制器是否是tabbar
- (BOOL)judgeRootVCIsTabbar{
    return [[[[[UIApplication sharedApplication] delegate] window] rootViewController] isKindOfClass:[XBaseTabBarViewController class]];
}



/// 判断是否还有需要跳转的路由，有的话就进行跳转
- (void)judgeExistLinkUrlStr{
    NSString * linkUrlStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"linkUrlStr"];
    if (!FLStringIsEmpty(linkUrlStr) && [XUserInfo checkLoginStatus]) {
        [[XRouter sharedInstance] routerWithLinkUrlStr:linkUrlStr];
    }
}

/// 加载控制器和赋值
/// @param urlStr 路由连接
- (XBaseViewController *)loadVCData:(NSString *)urlStr{
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * path = url.path;
    NSRange queryRange = [urlStr rangeOfString:path];
    NSString * query = @"";
    if (queryRange.location + queryRange.length < urlStr.length) {
        query = [urlStr substringFromIndex:queryRange.location + queryRange.length + 1];
    }
    NSArray * queryArray = [query componentsSeparatedByString:@"&"];
    for (NSString * queryStr in queryArray) {
        NSArray * arr = [queryStr componentsSeparatedByString:@"="];
        NSString * key = [arr firstObject];
        NSString * value = [arr lastObject];
        [dic setObject:value forKey:key];
    }
    NSArray * vcArray = [path componentsSeparatedByString:@"/"];
    if (vcArray.count == 3) {
        NSString* className = vcArray[2];
        Class pushVCClass = NSClassFromString(className);
        BOOL isSubClass = [pushVCClass isSubclassOfClass:[XBaseViewController class]] || [pushVCClass isSubclassOfClass:[UIViewController class]];
        if (isSubClass) {
            id resultVC = nil;
            resultVC = (XBaseViewController*)[[pushVCClass alloc] init];
            //属性赋值，一直找到 FLBaseViewController
            [pushVCClass mj_enumerateClasses:^(__unsafe_unretained Class c, BOOL *stop) {
                unsigned int outCount = 0;
                objc_property_t * properties = class_copyPropertyList(c , &outCount);
                for (int i = 0; i < outCount; i++) {
                    objc_property_t property = properties[i];
                    NSString *key = [NSString stringWithUTF8String:property_getName(property)];
                    NSString *param = dic[key];
                    if (param != nil) {
                        [resultVC setValue:param forKey:key];
                    }
                }
                if (c == [XBaseViewController class]) {
                    *stop = true;
                }
                free(properties);
            }];
            
            
            return resultVC;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

/// 获取连接类型
/// @param urlStr 连接
- (XUrlType)getUrlType:(NSString *)urlStr{
    XUrlType type = XUrlTypeError;
    NSString * scheme = @"";
    if (FLStringIsEmpty(urlStr) || urlStr.length < 5) {
        return type;
    }else{
        scheme = [urlStr substringToIndex:5];
    }
    if ([scheme containsString:@"http"]) {
        type = XUrlTypeWeb;
    }else if ([scheme containsString:@"fltrp"]){
        type = XUrlTypeNative;
    }else{
        type = XUrlTypeError;
    }
    return type;
}
 

@end

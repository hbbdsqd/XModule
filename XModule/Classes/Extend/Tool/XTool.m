//
//  XTool.m
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import "XTool.h"

@implementation XTool

+(UIViewController *)getcurController{
    return [XTool getTopViewController];
}
/*
 获得window最顶层视图 presented和push都可以用
 */
+ (UIViewController *)getTopViewController
{
    UIViewController *resultVC;
    /*
     获得做present动作的Controller
     */
    resultVC = [[self class] getCurrentTopViewController];
    /*
     获得present出来的最上层的Controller
     */
    while (resultVC.presentedViewController)
    {
        resultVC = [[self class] topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

/*
 获得想要的window最顶层视图 push出去的
 */
+ (UIViewController *)getCurrentTopViewController
{
    /*
     当有多个window时候  不能用这个方式获得window  keyWindow默认获得最顶层Window 当用了alertview等提示框时候  在最初的window之上会有一个新的window 获得的最顶层controller就不是我们想要的那个controller
     [UIApplication sharedApplication].keyWindow
     */
    return [[self class] topViewController:[[[[UIApplication sharedApplication] delegate] window] rootViewController]];
}
/*
 判断是TabBarController还是NavigationController
 不同的类型的controller取最上层视图的方式不同
 */
+ (UIViewController *)topViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:NSClassFromString(@"FLBaseNavigationController")])
    {
        return [[self class] topViewController:[(UINavigationController *)vc topViewController]];
    }
    else if ([vc isKindOfClass:NSClassFromString(@"FLBaseTabBarController")])
    {
        return [[self class] topViewController:[(UITabBarController *)vc selectedViewController]];
    }
    else
    {
        return vc;
    }
    return nil;
}

@end


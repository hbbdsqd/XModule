//
//  XTost.m
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import "XToast.h"

@implementation XToast

#pragma mark 显示一条信息
+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    [self show:message icon:nil view:view];
}

#pragma mark 显示带图片或者不带图片的信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    [self hideHUD];
    if (FLStringIsEmpty(text)) {
        text = @"";
    }
    if (view == nil) {
        NSArray * windowsArray = [UIApplication sharedApplication].windows;
        UIWindow * window = [windowsArray lastObject];
        NSInteger index = 1;
        while ([self searchContainsWindow:window]) {
            index++;
            window = windowsArray[windowsArray.count - index];
        }
        view = window;
        if (view == nil) {
            view = [UIView new];
        }
    }
    NSLog(@"%@",[[UIApplication sharedApplication] delegate].window);
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = text;
    hud.label.font=XGetFont(14);
    hud.label.textColor=[UIColor whiteColor];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.layer.cornerRadius=5;
    hud.label.numberOfLines = 0;
//    hud.userInteractionEnabled = NO;
//    hud.clipsToBounds=YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.margin = 10.f;
    // 判断是否显示图片
    if (icon == nil) {
        hud.mode = MBProgressHUDModeText;
    }else{
        // 设置图片
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        img = img == nil ? [UIImage imageNamed:icon] : img;
        hud.customView = [[UIImageView alloc]initWithImage:img];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后再消失
    [hud hideAnimated:YES afterDelay:kHudShowTime];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"mb_success" view:view];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"mb_error" view:view];
}

#pragma mark 显示警告信息
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view{
    [self show:Warning icon:@"mb_warn" view:view];
}

#pragma mark 显示自定义图片信息
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view{
    [self show:message icon:imageName view:view];
}

#pragma mark 加载中
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view{
    if (view == nil) {
        NSArray * windowsArray = [UIApplication sharedApplication].windows;
        UIWindow * window = [windowsArray lastObject];
        NSInteger index = 1;
        while ([self searchContainsWindow:window]) {
            index++;
            window = windowsArray[windowsArray.count - index];
        }
        view = window;
        if (view == nil) {
            view = [UIView new];
        }
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 细节文字
    //    hud.detailsLabelText = @"请耐心等待";
    // 再设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    
//    hud.userInteractionEnabled = NO;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 指定时间之后再消失
    [hud hideAnimated:YES afterDelay:10];
    
    return hud;
}

+ (MBProgressHUD *)showProgressBarToView:(UIView *)view{
    if (view == nil) {
        NSArray * windowsArray = [UIApplication sharedApplication].windows;
        UIWindow * window = [windowsArray lastObject];
        NSInteger index = 1;
        while ([self searchContainsWindow:window]) {
            index++;
            window = windowsArray[windowsArray.count - index];
        }
        view = window;
        if (view == nil) {
            view = [UIView new];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"加载中...";
    
//    hud.userInteractionEnabled = NO;
    
    // 指定时间之后再消失
    [hud hideAnimated:YES afterDelay:10];
    return hud;
}

+ (void)showMessage:(NSString *)message{
    [self showMessage:message toView:nil];
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHUD];
        [self showMessage:error];
    });
}

+ (void)showWarning:(NSString *)Warning{
    [self showWarning:Warning toView:nil];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message{
    [self showMessageWithImageName:imageName message:message toView:nil];
}

+ (MBProgressHUD *)showActivityMessage:(NSString*)message{
    return [self showActivityMessage:message view:nil];
}
 
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) {
        NSArray * windowsArray = [UIApplication sharedApplication].windows;
        UIWindow * window = [windowsArray lastObject];
        NSInteger index = 1;
        while ([self searchContainsWindow:window]) {
            index++;
            window = windowsArray[windowsArray.count - index];
        }
        view = window;
    }
    [self hideAllHUDsForView:view animated:YES];
}

+ (void)hideHUD{
    [self hideHUDForView:[XTool getcurController].view];
    NSArray * windowsArray = [UIApplication sharedApplication].windows;
    UIWindow * window = [windowsArray lastObject];
    NSInteger index = 1;
    while ([self searchContainsWindow:window]) {
        index++;
        window = windowsArray[windowsArray.count - index];
    }
    [self hideHUDForView:window];
}

+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated {
    NSArray *huds = [self allHUDsForView:view];
    for (MBProgressHUD *hud in huds) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:animated];
    }
    return [huds count];
}

+ (NSArray *)allHUDsForView:(UIView *)view {
    if (!view) {
        return @[];
    }
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:self]) {
            [huds addObject:aView];
        }
    }
    return [NSArray arrayWithArray:huds];
}

+ (BOOL)searchContainsWindow:(UIWindow *)window{
    return [NSStringFromClass([window class]) isEqualToString:@"YKWPluginsWindow"] || [NSStringFromClass([window class]) isEqualToString:@"UIRemoteKeyboardWindow"] || [NSStringFromClass([window class]) isEqualToString:@"SuperPlayerWindow"] || [NSStringFromClass([window class]) isEqualToString:@"UITextEffectsWindow"];
}

@end

//
//  XTost.h
//  XModule
//
//  Created by 苏秋东 on 2021/5/24.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface XToast : MBProgressHUD

// 统一的显示时长
#define kHudShowTime 1.5

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *_Nullable)message toView:(UIView * _Nullable )view;
+ (void)showSuccess:(NSString *_Nullable)success toView:(UIView * _Nullable )view;
+ (void)showError:(NSString *_Nullable)error toView:(UIView *_Nullable )view;
+ (void)showWarning:(NSString *_Nullable)Warning toView:(UIView *_Nullable )view;
+ (void)showMessageWithImageName:(NSString *_Nullable)imageName message:(NSString *_Nullable)message toView:(UIView * _Nullable)view;
+ (MBProgressHUD *_Nullable)showActivityMessage:(NSString*_Nullable)message view:(UIView * _Nullable)view;
+ (MBProgressHUD *_Nullable)showProgressBarToView:(UIView *_Nullable )view;


#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *_Nullable)message;
+ (void)showSuccess:(NSString *_Nullable)success;
+ (void)showError:(NSString *_Nullable)error;
+ (void)showWarning:(NSString *_Nullable)Warning;
+ (void)showMessageWithImageName:(NSString *_Nullable)imageName message:(NSString *_Nullable)message;
+ (MBProgressHUD *_Nullable)showActivityMessage:(NSString*_Nullable)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *_Nullable)view;
+ (void)hideHUD;
@end

NS_ASSUME_NONNULL_END

//
//  UIViewController+BackButtonTouched.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^WGKBackButtonHandler)(UIViewController *vc);
@interface UIViewController (WGKBackButtonTouched)
/**
 *  @author WGKCategories
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler <#backButtonHandler description#>
 */
-(void)wgk_backButtonTouched:(WGKBackButtonHandler)backButtonHandler;
@end

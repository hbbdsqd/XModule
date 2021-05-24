//
//  UIViewController+BackButtonTouched.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+WGKBackButtonTouched.h"
#import <objc/runtime.h>
static const void *WGKBackButtonHandlerKey = &WGKBackButtonHandlerKey;

@implementation UIViewController (WGKBackButtonTouched)
-(void)wgk_backButtonTouched:(WGKBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, WGKBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}
- (WGKBackButtonHandler)wgk_backButtonTouched
{
    return objc_getAssociatedObject(self, WGKBackButtonHandlerKey);
}
@end

@implementation UINavigationController (ShouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

   	UIViewController* vc = [self topViewController];
    WGKBackButtonHandler handler = [vc wgk_backButtonTouched];
    if (handler) {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906

        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }

	return NO;
}
@end

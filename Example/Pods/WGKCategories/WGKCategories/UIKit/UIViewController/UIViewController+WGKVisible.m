//
//  UIViewController+WGKVisible.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+WGKVisible.h"

@implementation UIViewController (WGKVisible)
- (BOOL)wgk_isVisible {
    return [self isViewLoaded] && self.view.window;
}
@end

//
//  UIButton+Block.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIButton+WGKBlock.h"
#import <objc/runtime.h>
static const void *wgk_UIButtonBlockKey = &wgk_UIButtonBlockKey;

@implementation UIButton (wgk_Block)
-(void)wgk_addActionHandler:(WGKTouchedButtonBlock)touchHandler{
    objc_setAssociatedObject(self, wgk_UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(wgk_blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)wgk_blockActionTouched:(UIButton *)btn{
    WGKTouchedButtonBlock block = objc_getAssociatedObject(self, wgk_UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end


//
//  UIControl+WGKActionBlocks.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIControl+WGKActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlWGKActionBlockArray = &UIControlWGKActionBlockArray;

@implementation UIControlWGKActionBlockWrapper

- (void)wgk_invokeBlock:(id)sender {
    if (self.wgk_actionBlock) {
        self.wgk_actionBlock(sender);
    }
}
@end


@implementation UIControl (WGKActionBlocks)
-(void)wgk_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlWGKActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self wgk_actionBlocksArray];
    
    UIControlWGKActionBlockWrapper *blockActionWrapper = [[UIControlWGKActionBlockWrapper alloc] init];
    blockActionWrapper.wgk_actionBlock = actionBlock;
    blockActionWrapper.wgk_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(wgk_invokeBlock:) forControlEvents:controlEvents];
}


- (void)wgk_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self wgk_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlWGKActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.wgk_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(wgk_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)wgk_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlWGKActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlWGKActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end

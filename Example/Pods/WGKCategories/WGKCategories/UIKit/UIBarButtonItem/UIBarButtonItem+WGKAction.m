//
//  UIBarButtonItem+WGKAction.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

char * const UIBarButtonItemWGKActionBlock = "UIBarButtonItemWGKActionBlock";
#import "UIBarButtonItem+WGKAction.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (WGKAction)

- (void)wgk_performActionBlock {
    
    dispatch_block_t block = self.wgk_actionBlock;
    
    if (block)
        block();
    
}

- (BarButtonWGKActionBlock)wgk_actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemWGKActionBlock);
}

- (void)setWgk_actionBlock:(BarButtonWGKActionBlock)actionBlock
 {
    
    if (actionBlock != self.wgk_actionBlock) {
        [self willChangeValueForKey:@"wgk_actionBlock"];
        
        objc_setAssociatedObject(self,
                                 UIBarButtonItemWGKActionBlock,
                                 actionBlock,
                                 OBJC_ASSOCIATION_COPY);
        
        // Sets up the action.
        [self setTarget:self];
        [self setAction:@selector(wgk_performActionBlock)];
        
        [self didChangeValueForKey:@"wgk_actionBlock"];
    }
}
@end

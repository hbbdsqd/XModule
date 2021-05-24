//
//  UIBarButtonItem+WGKAction.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BarButtonWGKActionBlock)(void);

@interface UIBarButtonItem (WGKAction)

/// A block that is run when the UIBarButtonItem is tapped.
//@property (nonatomic, copy) dispatch_block_t actionBlock;
- (void)setWgk_actionBlock:(BarButtonWGKActionBlock)actionBlock;

@end

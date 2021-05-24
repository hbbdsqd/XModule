//
//  UIControl+WGKActionBlocks.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/lavoy/ALActionBlocks

#import <UIKit/UIKit.h>
typedef void (^UIControlWGKActionBlock)(id weakSender);


@interface UIControlWGKActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlWGKActionBlock wgk_actionBlock;
@property (nonatomic, assign) UIControlEvents wgk_controlEvents;
- (void)wgk_invokeBlock:(id)sender;
@end



@interface UIControl (WGKActionBlocks)
- (void)wgk_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlWGKActionBlock)actionBlock;
- (void)wgk_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end

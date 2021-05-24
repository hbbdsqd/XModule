//
//  UIView+Recursion.m
//  WGKCategories
//
//  Created by Jakey on 15/6/23.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import "UIView+WGKRecursion.h"

@implementation UIView (WGKRecursion)
/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)wgk_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview wgk_findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}


-(void)wgk_runBlockOnAllSubviews:(WGKSubviewBlock)block
{
    block(self);
    for (UIView* view in [self subviews])
    {
        [view wgk_runBlockOnAllSubviews:block];
    }
}

-(void)wgk_runBlockOnAllSuperviews:(WGKSuperviewBlock)block
{
    block(self);
    if (self.superview)
    {
        [self.superview wgk_runBlockOnAllSuperviews:block];
    }
}

-(void)wgk_enableAllControlsInViewHierarchy
{
    [self wgk_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:YES];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

-(void)wgk_disableAllControlsInViewHierarchy
{
    [self wgk_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:NO];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:NO];
        }
    }];
}
@end

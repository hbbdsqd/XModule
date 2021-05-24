//
//  UIView+Recursion.h
//  WGKCategories
//
//  Created by Jakey on 15/6/23.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WGKSubviewBlock) (UIView* view);
typedef void (^WGKSuperviewBlock) (UIView* superview);
@interface UIView (WGKRecursion)

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)wgk_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;


-(void)wgk_runBlockOnAllSubviews:(WGKSubviewBlock)block;
-(void)wgk_runBlockOnAllSuperviews:(WGKSuperviewBlock)block;
-(void)wgk_enableAllControlsInViewHierarchy;
-(void)wgk_disableAllControlsInViewHierarchy;
@end

//
//  UIView+UIView_BlockGesture.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WGKGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (WGKBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)wgk_addTapActionWithBlock:(WGKGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)wgk_addLongPressActionWithBlock:(WGKGestureActionBlock)block;
@end

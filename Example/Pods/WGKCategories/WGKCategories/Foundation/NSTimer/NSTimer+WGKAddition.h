//
//  NSTimer+WGKAddition.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WGKAddition)
/**
 *  @brief  暂停NSTimer
 */
- (void)wgk_pauseTimer;
/**
 *  @brief  开始NSTimer
 */
- (void)wgk_resumeTimer;
/**
 *  @brief  延迟开始NSTimer
 */
- (void)wgk_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end

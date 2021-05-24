//
//  NSDate+WGKZeroDate.h
//  Jakey
//
//  Created by Jakey on 15/5/9.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WGKZeroDate)
+ (NSDate *)wgk_zeroTodayDate;
+ (NSDate *)wgk_zero24TodayDate;

- (NSDate *)wgk_zeroDate;
- (NSDate *)wgk_zero24Date;
@end

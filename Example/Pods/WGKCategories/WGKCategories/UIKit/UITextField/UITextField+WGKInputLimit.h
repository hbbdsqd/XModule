//
//  UITextField+WGKInputLimit.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 2016/11/29.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (WGKInputLimit)
@property (assign, nonatomic)  NSInteger wgk_maxLength;//if <=0, no limit
@end

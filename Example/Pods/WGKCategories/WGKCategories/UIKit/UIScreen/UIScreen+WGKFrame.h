//
//  UIScreen+WGKFrame.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (WGKFrame)
+ (CGSize)wgk_size;
+ (CGFloat)wgk_width;
+ (CGFloat)wgk_height;

+ (CGSize)wgk_orientationSize;
+ (CGFloat)wgk_orientationWidth;
+ (CGFloat)wgk_orientationHeight;
+ (CGSize)wgk_DPISize;

@end

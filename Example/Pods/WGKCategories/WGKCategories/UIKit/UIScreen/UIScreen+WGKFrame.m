//
//  UIScreen+WGKFrame.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIScreen+WGKFrame.h"

@implementation UIScreen (WGKFrame)
+ (CGSize)wgk_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)wgk_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)wgk_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)wgk_orientationSize
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion]
                             doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? wgk_SizeSWAP([UIScreen wgk_size]) : [UIScreen wgk_size];
}

+ (CGFloat)wgk_orientationWidth
{
    return [UIScreen wgk_orientationSize].width;
}

+ (CGFloat)wgk_orientationHeight
{
    return [UIScreen wgk_orientationSize].height;
}

+ (CGSize)wgk_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}


/**
 *  交换高度与宽度
 */
static inline CGSize wgk_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}
@end

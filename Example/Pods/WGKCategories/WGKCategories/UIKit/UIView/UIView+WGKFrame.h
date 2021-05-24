//
//  UIView+WGKFrame.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WGKFrame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint wgk_origin;
@property (nonatomic, assign) CGSize wgk_size;

// shortcuts for positions
@property (nonatomic) CGFloat wgk_centerX;
@property (nonatomic) CGFloat wgk_centerY;


@property (nonatomic) CGFloat wgk_top;
@property (nonatomic) CGFloat wgk_bottom;
@property (nonatomic) CGFloat wgk_right;
@property (nonatomic) CGFloat wgk_left;

@property (nonatomic) CGFloat wgk_width;
@property (nonatomic) CGFloat wgk_height;
@end

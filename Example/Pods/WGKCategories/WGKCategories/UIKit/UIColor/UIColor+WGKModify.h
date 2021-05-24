//
//  UIColor+Modify.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/1/2.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WGKModify)
- (UIColor *)wgk_invertedColor;
- (UIColor *)wgk_colorForTranslucency;
- (UIColor *)wgk_lightenColor:(CGFloat)lighten;
- (UIColor *)wgk_darkenColor:(CGFloat)darken;
@end

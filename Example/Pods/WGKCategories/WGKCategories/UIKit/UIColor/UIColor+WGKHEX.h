//
//  UIColor+HEX.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WGKHEX)
+ (UIColor *)wgk_colorWithHex:(UInt32)hex;
+ (UIColor *)wgk_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)wgk_colorWithHexString:(NSString *)hexString;
- (NSString *)wgk_HEXString;
///值不需要除以255.0
+ (UIColor *)wgk_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;
///值不需要除以255.0
+ (UIColor *)wgk_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;
@end

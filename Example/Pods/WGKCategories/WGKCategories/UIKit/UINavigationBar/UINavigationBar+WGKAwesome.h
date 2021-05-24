//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//  https://github.com/ltebean/LTNavigationBar

#import <UIKit/UIKit.h>

@interface UINavigationBar (WGKAwesome)
- (void)wgk_setBackgroundColor:(UIColor *)backgroundColor;
- (void)wgk_setElementsAlpha:(CGFloat)alpha;
- (void)wgk_setTranslationY:(CGFloat)translationY;
- (void)wgk_reset;
@end
//
//  UIView+CustomBorder.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//
/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, WGKExcludePoint) {
    WGKExcludeStartPoint = 1 << 0,
    WGKExcludeEndPoint = 1 << 1,
    WGKExcludeAllPoint = ~0UL
};


@interface UIView (WGKCustomBorder)

- (void)wgk_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)wgk_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)wgk_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)wgk_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)wgk_removeTopBorder;
- (void)wgk_removeLeftBorder;
- (void)wgk_removeBottomBorder;
- (void)wgk_removeRightBorder;


- (void)wgk_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(WGKExcludePoint)edge;
- (void)wgk_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(WGKExcludePoint)edge;
- (void)wgk_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(WGKExcludePoint)edge;
- (void)wgk_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(WGKExcludePoint)edge;
@end

//
//  UIView+WGKFrame.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+WGKFrame.h"

@implementation UIView (WGKFrame)
#pragma mark - Shortcuts for the coords

- (CGFloat)wgk_top
{
    return self.frame.origin.y;
}

- (void)setWgk_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)wgk_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWgk_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)wgk_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWgk_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)wgk_left
{
    return self.frame.origin.x;
}

- (void)setWgk_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)wgk_width
{
    return self.frame.size.width;
}

- (void)setWgk_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)wgk_height
{
    return self.frame.size.height;
}

- (void)setWgk_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)wgk_origin {
    return self.frame.origin;
}

- (void)setWgk_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)wgk_size {
    return self.frame.size;
}

- (void)setWgk_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)wgk_centerX {
    return self.center.x;
}

- (void)setWgk_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)wgk_centerY {
    return self.center.y;
}

- (void)setWgk_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end

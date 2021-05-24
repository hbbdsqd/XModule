//
//  UIScrollView+WGKAddition.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIScrollView+WGKAddition.h"

@implementation UIScrollView (WGKAddition)
//frame
- (CGFloat)wgk_contentWidth {
    return self.contentSize.width;
}
- (void)setWgk_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)wgk_contentHeight {
    return self.contentSize.height;
}
- (void)setWgk_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)wgk_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setWgk_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)wgk_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setWgk_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)wgk_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)wgk_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)wgk_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)wgk_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (WGKScrollDirection)wgk_ScrollDirection
{
    WGKScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = WGKScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = WGKScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = WGKScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = WGKScrollDirectionRight;
    }
    else
    {
        direction = WGKScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)wgk_isScrolledToTop
{
    return self.contentOffset.y <= [self wgk_topContentOffset].y;
}
- (BOOL)wgk_isScrolledToBottom
{
    return self.contentOffset.y >= [self wgk_bottomContentOffset].y;
}
- (BOOL)wgk_isScrolledToLeft
{
    return self.contentOffset.x <= [self wgk_leftContentOffset].x;
}
- (BOOL)wgk_isScrolledToRight
{
    return self.contentOffset.x >= [self wgk_rightContentOffset].x;
}
- (void)wgk_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self wgk_topContentOffset] animated:animated];
}
- (void)wgk_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self wgk_bottomContentOffset] animated:animated];
}
- (void)wgk_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self wgk_leftContentOffset] animated:animated];
}
- (void)wgk_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self wgk_rightContentOffset] animated:animated];
}
- (NSUInteger)wgk_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)wgk_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)wgk_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)wgk_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end

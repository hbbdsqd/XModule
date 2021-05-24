//
//  UIScrollView+WGKAddition.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WGKScrollDirection) {
    WGKScrollDirectionUp,
    WGKScrollDirectionDown,
    WGKScrollDirectionLeft,
    WGKScrollDirectionRight,
    WGKScrollDirectionWTF
};

@interface UIScrollView (WGKAddition)
@property(nonatomic) CGFloat wgk_contentWidth;
@property(nonatomic) CGFloat wgk_contentHeight;
@property(nonatomic) CGFloat wgk_contentOffsetX;
@property(nonatomic) CGFloat wgk_contentOffsetY;

- (CGPoint)wgk_topContentOffset;
- (CGPoint)wgk_bottomContentOffset;
- (CGPoint)wgk_leftContentOffset;
- (CGPoint)wgk_rightContentOffset;

- (WGKScrollDirection)wgk_ScrollDirection;

- (BOOL)wgk_isScrolledToTop;
- (BOOL)wgk_isScrolledToBottom;
- (BOOL)wgk_isScrolledToLeft;
- (BOOL)wgk_isScrolledToRight;
- (void)wgk_scrollToTopAnimated:(BOOL)animated;
- (void)wgk_scrollToBottomAnimated:(BOOL)animated;
- (void)wgk_scrollToLeftAnimated:(BOOL)animated;
- (void)wgk_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)wgk_verticalPageIndex;
- (NSUInteger)wgk_horizontalPageIndex;

- (void)wgk_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)wgk_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end

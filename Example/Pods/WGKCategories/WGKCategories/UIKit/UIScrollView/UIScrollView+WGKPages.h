//
//  UIScrollView+WGKPages.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (WGKPages)
- (NSInteger)wgk_pages;
- (NSInteger)wgk_currentPage;
- (CGFloat)wgk_scrollPercent;

- (CGFloat)wgk_pagesY;
- (CGFloat)wgk_pagesX;
- (CGFloat)wgk_currentPageY;
- (CGFloat)wgk_currentPageX;
- (void)wgk_setPageY:(CGFloat)page;
- (void)wgk_setPageX:(CGFloat)page;
- (void)wgk_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)wgk_setPageX:(CGFloat)page animated:(BOOL)animated;
@end

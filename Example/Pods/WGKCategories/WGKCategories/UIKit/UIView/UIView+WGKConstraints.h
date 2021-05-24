//
//  UIView+WGKConstraints.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WGKConstraints)
- (NSLayoutConstraint *)wgk_constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)wgk_leftConstraint;
- (NSLayoutConstraint *)wgk_rightConstraint;
- (NSLayoutConstraint *)wgk_topConstraint;
- (NSLayoutConstraint *)wgk_bottomConstraint;
- (NSLayoutConstraint *)wgk_leadingConstraint;
- (NSLayoutConstraint *)wgk_trailingConstraint;
- (NSLayoutConstraint *)wgk_widthConstraint;
- (NSLayoutConstraint *)wgk_heightConstraint;
- (NSLayoutConstraint *)wgk_centerXConstraint;
- (NSLayoutConstraint *)wgk_centerYConstraint;
- (NSLayoutConstraint *)wgk_baseLineConstraint;
@end

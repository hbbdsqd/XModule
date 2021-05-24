//
//  UIBarButtonItem+Badge.h
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//  https://github.com/mikeMTOL/UIBarButtonItem-Badge

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WGKBadge)

@property (strong, atomic) UILabel *wgk_badge;

// Badge value to be display
@property (nonatomic) NSString *wgk_badgeValue;
// Badge background color
@property (nonatomic) UIColor *wgk_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *wgk_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *wgk_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat wgk_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat wgk_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat wgk_badgeOriginX;
@property (nonatomic) CGFloat wgk_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL wgk_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL wgk_shouldAnimateBadge;

@end

//
//  UIBarButtonItem+Badge.m
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//
#import <objc/runtime.h>
#import "UIBarButtonItem+WGKBadge.h"

NSString const *wgk_UIBarButtonItem_badgeKey = @"wgk_UIBarButtonItem_badgeKey";

NSString const *wgk_UIBarButtonItem_badgeBGColorKey = @"wgk_UIBarButtonItem_badgeBGColorKey";
NSString const *wgk_UIBarButtonItem_badgeTextColorKey = @"wgk_UIBarButtonItem_badgeTextColorKey";
NSString const *wgk_UIBarButtonItem_badgeFontKey = @"wgk_UIBarButtonItem_badgeFontKey";
NSString const *wgk_UIBarButtonItem_badgePaddingKey = @"wgk_UIBarButtonItem_badgePaddingKey";
NSString const *wgk_UIBarButtonItem_badgeMinSizeKey = @"wgk_UIBarButtonItem_badgeMinSizeKey";
NSString const *wgk_UIBarButtonItem_badgeOriginXKey = @"wgk_UIBarButtonItem_badgeOriginXKey";
NSString const *wgk_UIBarButtonItem_badgeOriginYKey = @"wgk_UIBarButtonItem_badgeOriginYKey";
NSString const *wgk_UIBarButtonItem_shouldHideBadgeAtZeroKey = @"wgk_UIBarButtonItem_shouldHideBadgeAtZeroKey";
NSString const *wgk_UIBarButtonItem_shouldAnimateBadgeKey = @"wgk_UIBarButtonItem_shouldAnimateBadgeKey";
NSString const *wgk_UIBarButtonItem_badgeValueKey = @"wgk_UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (WGKBadge)

@dynamic wgk_badgeValue, wgk_badgeBGColor, wgk_badgeTextColor, wgk_badgeFont;
@dynamic wgk_badgePadding, wgk_badgeMinSize, wgk_badgeOriginX, wgk_badgeOriginY;
@dynamic wgk_shouldHideBadgeAtZero, wgk_shouldAnimateBadge;

- (void)wgk_badgeInit
{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.wgk_badge.frame.size.width/2;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.wgk_badge.frame.size.width;
    }
    [superview addSubview:self.wgk_badge];
    
    // Default design initialization
    self.wgk_badgeBGColor   = [UIColor redColor];
    self.wgk_badgeTextColor = [UIColor whiteColor];
    self.wgk_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.wgk_badgePadding   = 6;
    self.wgk_badgeMinSize   = 8;
    self.wgk_badgeOriginX   = defaultOriginX;
    self.wgk_badgeOriginY   = -4;
    self.wgk_shouldHideBadgeAtZero = YES;
    self.wgk_shouldAnimateBadge = YES;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)wgk_refreshBadge
{
    // Change new attributes
    self.wgk_badge.textColor        = self.wgk_badgeTextColor;
    self.wgk_badge.backgroundColor  = self.wgk_badgeBGColor;
    self.wgk_badge.font             = self.wgk_badgeFont;
    
    if (!self.wgk_badgeValue || [self.wgk_badgeValue isEqualToString:@""] || ([self.wgk_badgeValue isEqualToString:@"0"] && self.wgk_shouldHideBadgeAtZero)) {
        self.wgk_badge.hidden = YES;
    } else {
        self.wgk_badge.hidden = NO;
        [self wgk_updateBadgeValueAnimated:YES];
    }

}

- (CGSize)wgk_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self wgk_duplicateLabel:self.wgk_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)wgk_updateBadgeFrame
{

    CGSize expectedLabelSize = [self wgk_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.wgk_badgeMinSize) ? self.wgk_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.wgk_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.wgk_badge.layer.masksToBounds = YES;
    self.wgk_badge.frame = CGRectMake(self.wgk_badgeOriginX, self.wgk_badgeOriginY, minWidth + padding, minHeight + padding);
    self.wgk_badge.layer.cornerRadius = (minHeight + padding) / 2;
}

// Handle the badge changing value
- (void)wgk_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.wgk_shouldAnimateBadge && ![self.wgk_badge.text isEqualToString:self.wgk_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.wgk_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.wgk_badge.text = self.wgk_badgeValue;
    
    // Animate the size modification if needed
    if (animated && self.wgk_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self wgk_updateBadgeFrame];
        }];
    } else {
        [self wgk_updateBadgeFrame];
    }
}

- (UILabel *)wgk_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)wgk_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.wgk_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.wgk_badge removeFromSuperview];
        self.wgk_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)wgk_badge {
    UILabel* lbl = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeKey);
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.wgk_badgeOriginX, self.wgk_badgeOriginY, 20, 20)];
        [self setWgk_badge:lbl];
        [self wgk_badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}
-(void)setWgk_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)wgk_badgeValue {
    return objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeValueKey);
}
-(void)setWgk_vadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    [self wgk_updateBadgeValueAnimated:YES];
    [self wgk_refreshBadge];
}

// Badge background color
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Badge text color
-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Badge font
-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat)wgk_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setWgk_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat)wgk_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}
-(void) setWgk_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

-(CGFloat)wgk_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}
-(void) setWgk_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Badge has a bounce animation when value changes
-(BOOL) wgk_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setWgk_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &wgk_UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}


@end

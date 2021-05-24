//
//  UIBarButtonItem+Badge.m
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//
#import <objc/runtime.h>
#import "UIButton+WGKBadge.h"

NSString const *wgk_UIButton_badgeKey = @"wgk_UIButton_badgeKey";

NSString const *wgk_UIButton_badgeBGColorKey = @"wgk_UIButton_badgeBGColorKey";
NSString const *wgk_UIButton_badgeTextColorKey = @"wgk_UIButton_badgeTextColorKey";
NSString const *wgk_UIButton_badgeFontKey = @"wgk_UIButton_badgeFontKey";
NSString const *wgk_UIButton_badgePaddingKey = @"wgk_UIButton_badgePaddingKey";
NSString const *wgk_UIButton_badgeMinSizeKey = @"wgk_UIButton_badgeMinSizeKey";
NSString const *wgk_UIButton_badgeOriginXKey = @"wgk_UIButton_badgeOriginXKey";
NSString const *wgk_UIButton_badgeOriginYKey = @"wgk_UIButton_badgeOriginYKey";
NSString const *wgk_UIButton_shouldHideBadgeAtZeroKey = @"wgk_UIButton_shouldHideBadgeAtZeroKey";
NSString const *wgk_UIButton_shouldAnimateBadgeKey = @"wgk_UIButton_shouldAnimateBadgeKey";
NSString const *wgk_UIButton_badgeValueKey = @"wgk_UIButton_badgeValueKey";

@implementation UIButton (WGKBadge)

@dynamic wgk_badgeValue, wgk_badgeBGColor, wgk_badgeTextColor, wgk_badgeFont;
@dynamic wgk_badgePadding, wgk_badgeMinSize, wgk_badgeOriginX, wgk_badgeOriginY;
@dynamic wgk_shouldHideBadgeAtZero, wgk_shouldAnimateBadge;

- (void)wgk_badgeInit
{
    // Default design initialization
    self.wgk_badgeBGColor   = [UIColor redColor];
    self.wgk_badgeTextColor = [UIColor whiteColor];
    self.wgk_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.wgk_badgePadding   = 6;
    self.wgk_badgeMinSize   = 8;
    self.wgk_badgeOriginX   = self.frame.size.width - self.wgk_badge.frame.size.width/2;
    self.wgk_badgeOriginY   = -4;
    self.wgk_shouldHideBadgeAtZero = YES;
    self.wgk_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)wgk_refreshBadge
{
    // Change new attributes
    self.wgk_badge.textColor        = self.wgk_badgeTextColor;
    self.wgk_badge.backgroundColor  = self.wgk_badgeBGColor;
    self.wgk_badge.font             = self.wgk_badgeFont;
}

- (CGSize) wgk_badgeExpectedSize
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
    self.wgk_badge.frame = CGRectMake(self.wgk_badgeOriginX, self.wgk_badgeOriginY, minWidth + padding, minHeight + padding);
    self.wgk_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.wgk_badge.layer.masksToBounds = YES;
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
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self wgk_updateBadgeFrame];
    }];
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
    return objc_getAssociatedObject(self, &wgk_UIButton_badgeKey);
}
-(void)setWgk_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &wgk_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)wgk_badgeValue {
    return objc_getAssociatedObject(self, &wgk_UIButton_badgeValueKey);
}
-(void) setWgk_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &wgk_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.wgk_shouldHideBadgeAtZero)) {
        [self wgk_removeBadge];
    } else if (!self.wgk_badge) {
        // Create a new badge because not existing
        self.wgk_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.wgk_badgeOriginX, self.wgk_badgeOriginY, 20, 20)];
        self.wgk_badge.textColor            = self.wgk_badgeTextColor;
        self.wgk_badge.backgroundColor      = self.wgk_badgeBGColor;
        self.wgk_badge.font                 = self.wgk_badgeFont;
        self.wgk_badge.textAlignment        = NSTextAlignmentCenter;
        [self wgk_badgeInit];
        [self addSubview:self.wgk_badge];
        [self wgk_updateBadgeValueAnimated:NO];
    } else {
        [self wgk_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)wgk_badgeBGColor {
    return objc_getAssociatedObject(self, &wgk_UIButton_badgeBGColorKey);
}
-(void)setWgk_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &wgk_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Badge text color
-(UIColor *)wgk_badgeTextColor {
    return objc_getAssociatedObject(self, &wgk_UIButton_badgeTextColorKey);
}
-(void)setWgk_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &wgk_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Badge font
-(UIFont *)wgk_badgeFont {
    return objc_getAssociatedObject(self, &wgk_UIButton_badgeFontKey);
}
-(void)setWgk_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &wgk_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) wgk_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setWgk_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &wgk_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) wgk_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setWgk_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &wgk_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) wgk_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setWgk_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &wgk_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

-(CGFloat) wgk_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setWgk_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &wgk_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.wgk_badge) {
        [self wgk_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) wgk_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setWgk_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &wgk_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) wgk_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &wgk_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setWgk_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &wgk_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

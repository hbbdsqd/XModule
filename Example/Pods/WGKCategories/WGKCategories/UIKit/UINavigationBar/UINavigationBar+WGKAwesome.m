//
//  UINavigationBar+WGKAwesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+WGKAwesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (WGKAwesome)
static char wgk_overlayKey;

- (UIView *)wgk_overlay
{
    return objc_getAssociatedObject(self, &wgk_overlayKey);
}

- (void)setWgk_overlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &wgk_overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)wgk_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.wgk_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.wgk_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.wgk_overlay.userInteractionEnabled = NO;
        self.wgk_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.wgk_overlay atIndex:0];
    }
    self.wgk_overlay.backgroundColor = backgroundColor;
}

- (void)wgk_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)wgk_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)wgk_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.wgk_overlay removeFromSuperview];
    self.wgk_overlay = nil;
}

@end

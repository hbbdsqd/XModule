//
//  UIButton+Submitting.m
//  FXCategories
//
//  Created by foxsofter on 15/4/2.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIButton+WGKSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *wgk_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *wgk_spinnerView;
@property(nonatomic, strong) UILabel *wgk_spinnerTitleLabel;

@end

@implementation UIButton (WGKSubmitting)

- (void)wgk_beginSubmitting:(NSString *)title {
    [self wgk_endSubmitting];
    
    self.wgk_submitting = @YES;
    self.hidden = YES;
    
    self.wgk_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.wgk_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.wgk_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.wgk_modalView.layer.borderWidth = self.layer.borderWidth;
    self.wgk_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.wgk_modalView.bounds;
    self.wgk_spinnerView = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.wgk_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.wgk_spinnerView.bounds;
    self.wgk_spinnerView.frame = CGRectMake(
                                        15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                        spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.wgk_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.wgk_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.wgk_spinnerTitleLabel.text = title;
    self.wgk_spinnerTitleLabel.font = self.titleLabel.font;
    self.wgk_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.wgk_modalView addSubview:self.wgk_spinnerView];
    [self.wgk_modalView addSubview:self.wgk_spinnerTitleLabel];
    [self.superview addSubview:self.wgk_modalView];
    [self.wgk_spinnerView startAnimating];
}

- (void)wgk_endSubmitting {
    if (!self.isWGKSubmitting.boolValue) {
        return;
    }
    
    self.wgk_submitting = @NO;
    self.hidden = NO;
    
    [self.wgk_modalView removeFromSuperview];
    self.wgk_modalView = nil;
    self.wgk_spinnerView = nil;
    self.wgk_spinnerTitleLabel = nil;
}

- (NSNumber *)isWGKSubmitting {
    return objc_getAssociatedObject(self, @selector(setWgk_submitting:));
}

- (void)setWgk_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setWgk_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)wgk_spinnerView {
    return objc_getAssociatedObject(self, @selector(setWgk_spinnerView:));
}

- (void)setWgk_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setWgk_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)wgk_modalView {
    return objc_getAssociatedObject(self, @selector(setWgk_modalView:));

}

- (void)setWgk_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setWgk_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)wgk_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setWgk_spinnerTitleLabel:));
}

- (void)setWgk_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setWgk_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

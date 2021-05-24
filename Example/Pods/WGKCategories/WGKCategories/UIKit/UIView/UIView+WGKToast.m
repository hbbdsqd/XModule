//
//  UIView+Toast.m
//  Toast
//
//  Copyright 2014 Charles Scalesse.
//


#import "UIView+WGKToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat WGKToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat WGKToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat WGKToastHorizontalPadding   = 10.0;
static const CGFloat WGKToastVerticalPadding     = 10.0;
static const CGFloat WGKToastCornerRadius        = 10.0;
static const CGFloat WGKToastOpacity             = 0.8;
static const CGFloat WGKToastFontSize            = 16.0;
static const CGFloat WGKToastMaxTitleLines       = 0;
static const CGFloat WGKToastMaxMessageLines     = 0;
static const NSTimeInterval WGKToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat WGKToastShadowOpacity       = 0.8;
static const CGFloat WGKToastShadowRadius        = 6.0;
static const CGSize  WGKToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    WGKToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval WGKToastDefaultDuration  = 3.0;

// image view size
static const CGFloat WGKToastImageViewWidth      = 80.0;
static const CGFloat WGKToastImageViewHeight     = 80.0;

// activity
static const CGFloat WGKToastActivityWidth       = 100.0;
static const CGFloat WGKToastActivityHeight      = 100.0;
static const NSString * WGKToastActivityDefaultPosition = @"center";

// interaction
static const BOOL WGKToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * WGKToastTimerKey         = @"WGKToastTimerKey";
static const NSString * WGKToastActivityViewKey  = @"WGKToastActivityViewKey";
static const NSString * WGKToastTapCallbackKey   = @"WGKToastTapCallbackKey";

// positions
NSString * const WGKToastPositionTop             = @"top";
NSString * const WGKToastPositionCenter          = @"center";
NSString * const WGKToastPositionBottom          = @"bottom";

@interface UIView (WGKToastPrivate)

- (void)wgk_hideToast:(UIView *)toast;
- (void)wgk_toastTimerDidFinish:(NSTimer *)timer;
- (void)wgk_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)wgk_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)wgk_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)wgk_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@implementation UIView (WGKToast)

#pragma mark - Toast Methods

- (void)wgk_makeToast:(NSString *)message {
    [self wgk_makeToast:message duration:WGKToastDefaultDuration position:nil];
}

- (void)wgk_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self wgk_viewForMessage:message title:nil image:nil];
    [self wgk_showToast:toast duration:duration position:position];
}

- (void)wgk_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self wgk_viewForMessage:message title:title image:nil];
    [self wgk_showToast:toast duration:duration position:position];
}

- (void)wgk_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self wgk_viewForMessage:message title:nil image:image];
    [self wgk_showToast:toast duration:duration position:position];
}

- (void)wgk_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self wgk_viewForMessage:message title:title image:image];
    [self wgk_showToast:toast duration:duration position:position];
}

- (void)wgk_showToast:(UIView *)toast {
    [self wgk_showToast:toast duration:WGKToastDefaultDuration position:nil];
}


- (void)wgk_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self wgk_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)wgk_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self wgk_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (WGKToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(wgk_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:WGKToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(wgk_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &WGKToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &WGKToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)wgk_hideToast:(UIView *)toast {
    [UIView animateWithDuration:WGKToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)wgk_toastTimerDidFinish:(NSTimer *)timer {
    [self wgk_hideToast:(UIView *)timer.userInfo];
}

- (void)wgk_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &WGKToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &WGKToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self wgk_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)wgk_makeToastActivity {
    [self wgk_makeToastActivity:WGKToastActivityDefaultPosition];
}

- (void)wgk_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &WGKToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WGKToastActivityWidth, WGKToastActivityHeight)];
    activityView.center = [self wgk_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:WGKToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = WGKToastCornerRadius;
    
    if (WGKToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = WGKToastShadowOpacity;
        activityView.layer.shadowRadius = WGKToastShadowRadius;
        activityView.layer.shadowOffset = WGKToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &WGKToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:WGKToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)wgk_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &WGKToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:WGKToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &WGKToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)wgk_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:WGKToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + WGKToastVerticalPadding);
        } else if([point caseInsensitiveCompare:WGKToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - WGKToastVerticalPadding);
}

- (CGSize)wgk_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)wgk_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;

    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = WGKToastCornerRadius;
    
    if (WGKToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = WGKToastShadowOpacity;
        wrapperView.layer.shadowRadius = WGKToastShadowRadius;
        wrapperView.layer.shadowOffset = WGKToastShadowOffset;
    }

    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:WGKToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(WGKToastHorizontalPadding, WGKToastVerticalPadding, WGKToastImageViewWidth, WGKToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = WGKToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = WGKToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:WGKToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * WGKToastMaxWidth) - imageWidth, self.bounds.size.height * WGKToastMaxHeight);
        CGSize expectedSizeTitle = [self wgk_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = WGKToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:WGKToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * WGKToastMaxWidth) - imageWidth, self.bounds.size.height * WGKToastMaxHeight);
        CGSize expectedSizeMessage = [self wgk_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = WGKToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + WGKToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;

    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + WGKToastHorizontalPadding;
        messageTop = titleTop + titleHeight + WGKToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }

    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (WGKToastHorizontalPadding * 2)), (longerLeft + longerWidth + WGKToastHorizontalPadding));    
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + WGKToastVerticalPadding), (imageHeight + (WGKToastVerticalPadding * 2)));
                         
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
        
    return wrapperView;
}

@end

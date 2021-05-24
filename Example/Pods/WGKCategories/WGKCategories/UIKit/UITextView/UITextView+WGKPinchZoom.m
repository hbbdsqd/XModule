//
//  UITextView+PinchZoom.m
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//

#import "UITextView+WGKPinchZoom.h"
#import "objc/runtime.h"

static int wgk_minFontSizeKey;
static int wgk_maxFontSizeKey;
static int wgk_zoomEnabledKey;

@implementation UITextView (WGKPinchZoom)

- (void)setWgk_maxFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &wgk_maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wgk_maxFontSize
{
    return [objc_getAssociatedObject(self, &wgk_maxFontSizeKey) floatValue];
}

- (void)setWgk_minFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &wgk_minFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wgk_minFontSize
{
    return [objc_getAssociatedObject(self, &wgk_minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if (!self.isJk_zoomEnabled) return;

    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;

    pointSize = MAX(MIN(pointSize, self.wgk_maxFontSize), self.wgk_minFontSize);

    self.font = [UIFont fontWithName:self.font.fontName size:pointSize];
}


- (void)setWgk_zoomEnabled:(BOOL)zoomEnabled
{
    objc_setAssociatedObject(self, &wgk_zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;

        self.wgk_minFontSize = self.wgk_minFontSize ?: 8.0f;
        self.wgk_maxFontSize = self.wgk_maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
#if !__has_feature(objc_arc)
        [pinchRecognizer release];
#endif
    }
}

- (BOOL)isJk_zoomEnabled
{
    return [objc_getAssociatedObject(self, &wgk_zoomEnabledKey) boolValue];
}

@end

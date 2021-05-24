//
//  UITextView+PlaceHolder.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UITextView+WGKPlaceHolder.h"
static const char *wgk_placeHolderTextView = "wgk_placeHolderTextView";

@implementation UITextView (WGKPlaceHolder)
- (UITextView *)wgk_placeHolderTextView {
    return objc_getAssociatedObject(self, wgk_placeHolderTextView);
}
- (void)setWgk_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, wgk_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)wgk_addPlaceHolder:(NSString *)placeHolder {
    if (![self wgk_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setWgk_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];

    }
    self.wgk_placeHolderTextView.text = placeHolder;
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.wgk_placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.wgk_placeHolderTextView.hidden = NO;
    }
}
+ (void)load {
    [super load];
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(wgk_textView_placeholder_swizzledDealloc));
    method_exchangeImplementations(origMethod, newMethod);
}
- (void)wgk_textView_placeholder_swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self wgk_textView_placeholder_swizzledDealloc];
}
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end

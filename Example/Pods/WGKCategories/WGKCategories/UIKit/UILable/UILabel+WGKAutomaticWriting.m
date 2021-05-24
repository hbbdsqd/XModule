//
//  UILabel+AutomaticWriting.m
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//

#import "UILabel+WGKAutomaticWriting.h"
#import <objc/runtime.h>


NSTimeInterval const UILabelAWDefaultDuration = 0.4f;

unichar const UILabelAWDefaultCharacter = 124;

static inline void wgk_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;


@implementation UILabel (WGKAutomaticWriting)

@dynamic wgk_automaticWritingOperationQueue, wgk_edgeInsets;

#pragma mark - Public Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wgk_AutomaticWritingSwizzleSelector([self class], @selector(textRectForBounds:limitedToNumberOfLines:), @selector(wgk_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        wgk_AutomaticWritingSwizzleSelector([self class], @selector(drawTextInRect:), @selector(wgk_drawAutomaticWritingTextInRect:));
    });
}

-(void)wgk_drawAutomaticWritingTextInRect:(CGRect)rect
{
    [self wgk_drawAutomaticWritingTextInRect:UIEdgeInsetsInsetRect(rect, self.wgk_edgeInsets)];
}

- (CGRect)wgk_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self wgk_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.wgk_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setWgk_edgeInsets:(UIEdgeInsets)edgeInsets
{
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)wgk_edgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    
    if (edgeInsetsValue)
    {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return edgeInsetsValue.UIEdgeInsetsValue;
}

- (void)setWgk_automaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue
{
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)wgk_automaticWritingOperationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    
    if (operationQueue)
    {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return operationQueue;
}

- (void)wgk_setTextWithAutomaticWritingAnimation:(NSString *)text
{
    [self wgk_setText:text automaticWritingAnimationWithBlinkingMode:UILabelWGKlinkingModeNone];
}

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelWGKlinkingMode)blinkingMode
{
    [self wgk_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration
{
    [self wgk_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelWGKlinkingModeNone];
}

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelWGKlinkingMode)blinkingMode
{
    [self wgk_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelWGKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter
{
    [self wgk_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelWGKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion
{
    self.wgk_automaticWritingOperationQueue.suspended = YES;
    self.wgk_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    
    if (text)
    {
        [automaticWritingText appendString:text];
    }
    
    [self.wgk_automaticWritingOperationQueue addOperationWithBlock:^{
        [self wgk_automaticWriting:automaticWritingText duration:duration mode:blinkingMode character:blinkingCharacter completion:completion];
    }];
}

#pragma mark - Private Methods

- (void)wgk_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelWGKlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion
{
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelWGKlinkingModeWhenFinish) && !currentQueue.isSuspended)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelWGKlinkingModeNone)
            {
                if ([self wgk_isLastCharacter:character])
                {
                    [self wgk_deleteLastCharacter];
                }
                else if (mode != UILabelWGKlinkingModeWhenFinish || !text.length)
                {
                    [text insertString:[self wgk_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length)
            {
                [self wgk_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self wgk_isLastCharacter:character] && mode == UILabelWGKlinkingModeWhenFinishShowing) || (!text.length && mode == UILabelWGKlinkingModeUntilFinishKeeping))
                {
                    [self wgk_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended)
            {
                [currentQueue addOperationWithBlock:^{
                    [self wgk_automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion)
            {
                completion();
            }
        });
    }
    else if (completion)
    {
        completion();
    }
}

- (NSString *)wgk_stringWithCharacter:(unichar)character
{
    return [self wgk_stringWithCharacters:@[@(character)]];
}

- (NSString *)wgk_stringWithCharacters:(NSArray *)characters
{
    NSMutableString *string = NSMutableString.new;
    
    for (NSNumber *character in characters)
    {
        [string appendFormat:@"%C", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)wgk_appendCharacter:(unichar)character
{
    [self wgk_appendCharacters:@[@(character)]];
}

- (void)wgk_appendCharacters:(NSArray *)characters
{
    self.text = [self.text stringByAppendingString:[self wgk_stringWithCharacters:characters]];
}

- (BOOL)wgk_isLastCharacters:(NSArray *)characters
{
    if (self.text.length >= characters.count)
    {
        return [self.text hasSuffix:[self wgk_stringWithCharacters:characters]];
    }
    return NO;
}

- (BOOL)wgk_isLastCharacter:(unichar)character
{
    return [self wgk_isLastCharacters:@[@(character)]];
}

- (BOOL)wgk_deleteLastCharacters:(NSUInteger)characters
{
    if (self.text.length >= characters)
    {
        self.text = [self.text substringToIndex:self.text.length-characters];
        return YES;
    }
    return NO;
}

- (BOOL)wgk_deleteLastCharacter
{
    return [self wgk_deleteLastCharacters:1];
}

@end

//
//  UILabel+AutomaticWriting.h
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//  https://github.com/alexruperez/UILabel-AutomaticWriting

#import <UIKit/UIKit.h>

//! Project version number for UILabel-AutomaticWriting.
FOUNDATION_EXPORT double UILabelAutomaticWritingVersionNumber;

//! Project version string for UILabel-AutomaticWriting.
FOUNDATION_EXPORT const unsigned char UILabelAutomaticWritingVersionString[];

extern NSTimeInterval const UILabelAWDefaultDuration;

extern unichar const UILabelAWDefaultCharacter;

typedef NS_ENUM(NSInteger, UILabelWGKlinkingMode)
{
    UILabelWGKlinkingModeNone,
    UILabelWGKlinkingModeUntilFinish,
    UILabelWGKlinkingModeUntilFinishKeeping,
    UILabelWGKlinkingModeWhenFinish,
    UILabelWGKlinkingModeWhenFinishShowing,
    UILabelWGKlinkingModeAlways
};

@interface UILabel (WGKAutomaticWriting)

@property (strong, nonatomic) NSOperationQueue *wgk_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets wgk_edgeInsets;

- (void)wgk_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelWGKlinkingMode)blinkingMode;

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelWGKlinkingMode)blinkingMode;

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelWGKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)wgk_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelWGKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;

@end
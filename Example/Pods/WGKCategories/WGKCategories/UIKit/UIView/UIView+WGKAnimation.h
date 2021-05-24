//
//  UIView+Animation.h
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 PT Software Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

float wgk_radiansForDegrees(int degrees);

@interface UIView (WGKAnimation)

// Moves
- (void)wgk_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)wgk_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)wgk_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)wgk_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)wgk_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)wgk_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)wgk_spinClockwise:(float)secs;
- (void)wgk_spinCounterClockwise:(float)secs;

// Transitions
- (void)wgk_curlDown:(float)secs;
- (void)wgk_curlUpAndAway:(float)secs;
- (void)wgk_drainAway:(float)secs;

// Effects
- (void)wgk_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)wgk_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)wgk_addSubviewWithFadeAnimation:(UIView *)subview;

@end

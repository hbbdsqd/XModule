//
//  UITextField+Shake.m
//  UITextField+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UITextField+WGKShake.h"

@implementation UITextField (WGKShake)

- (void)wgk_shake {
    [self wgk_shake:10 withDelta:5 completion:nil];
}

- (void)wgk_shake:(int)times withDelta:(CGFloat)delta {
    [self wgk_shake:times withDelta:delta completion:nil];
}

- (void)wgk_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self _wgk_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:WGKShakedDirectionHorizontal completion:handler];
}

- (void)wgk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self wgk_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)wgk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self _wgk_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:WGKShakedDirectionHorizontal completion:handler];
}

- (void)wgk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(WGKShakedDirection)shakeDirection {
    [self wgk_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)wgk_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(WGKShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [self _wgk_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_wgk_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(WGKShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == WGKShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self _wgk_shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:handler];
    }];
}

@end

//
//  UIControl+WGKBlock.h
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//  https://github.com/foxsofter/FXCategories
//  http://stackoverflow.com/questions/2437875/target-action-uicontrolevents
#import <UIKit/UIKit.h>

@interface UIControl (WGKBlock)

- (void)wgk_touchDown:(void (^)(void))eventBlock;
- (void)wgk_touchDownRepeat:(void (^)(void))eventBlock;
- (void)wgk_touchDragInside:(void (^)(void))eventBlock;
- (void)wgk_touchDragOutside:(void (^)(void))eventBlock;
- (void)wgk_touchDragEnter:(void (^)(void))eventBlock;
- (void)wgk_touchDragExit:(void (^)(void))eventBlock;
- (void)wgk_touchUpInside:(void (^)(void))eventBlock;
- (void)wgk_touchUpOutside:(void (^)(void))eventBlock;
- (void)wgk_touchCancel:(void (^)(void))eventBlock;
- (void)wgk_valueChanged:(void (^)(void))eventBlock;
- (void)wgk_editingDidBegin:(void (^)(void))eventBlock;
- (void)wgk_editingChanged:(void (^)(void))eventBlock;
- (void)wgk_editingDidEnd:(void (^)(void))eventBlock;
- (void)wgk_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
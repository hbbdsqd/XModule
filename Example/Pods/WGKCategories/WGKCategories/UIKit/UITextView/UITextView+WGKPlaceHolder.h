//
//  UITextView+PlaceHolder.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (WGKPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *wgk_placeHolderTextView;
- (void)wgk_addPlaceHolder:(NSString *)placeHolder;
@end

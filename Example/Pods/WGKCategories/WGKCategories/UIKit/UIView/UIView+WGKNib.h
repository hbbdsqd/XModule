//
//  UIView+Nib.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (WGKNib)
+ (UINib *)wgk_loadNib;
+ (UINib *)wgk_loadNibNamed:(NSString*)nibName;
+ (UINib *)wgk_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)wgk_loadInstanceFromNib;
+ (instancetype)wgk_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)wgk_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)wgk_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end

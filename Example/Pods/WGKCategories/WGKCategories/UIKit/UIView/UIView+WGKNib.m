//
//  UIView+Nib.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+WGKNib.h"

@implementation UIView (WGKNib)
#pragma mark - Nibs
+ (UINib *)wgk_loadNib
{
    return [self wgk_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)wgk_loadNibNamed:(NSString*)nibName
{
    return [self wgk_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)wgk_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)wgk_loadInstanceFromNib
{
    return [self wgk_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)wgk_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self wgk_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)wgk_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self wgk_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)wgk_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end

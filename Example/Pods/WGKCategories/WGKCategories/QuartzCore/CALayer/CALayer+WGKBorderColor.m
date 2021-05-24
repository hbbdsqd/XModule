//
//  CALayer+WGKBorderColor.m
//  test
//
//  Created by LiuLogan on 15/6/17.
//  Copyright (c) 2015年 Xidibuy. All rights reserved.
//

#import "CALayer+WGKBorderColor.h"

@implementation CALayer (WGKBorderColor)

-(void)setWgk_borderColor:(UIColor *)wgk_borderColor{
    self.borderColor = wgk_borderColor.CGColor;
}

- (UIColor*)wgk_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

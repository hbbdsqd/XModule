//
//  UIBezierPath+WGKBasicShapes.h
//  Example
//
//  Created by Pierre Dulac on 26/02/13.
//  Copyright (c) 2013 Pierre Dulac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (WGKBasicShapes)

+ (UIBezierPath *)wgk_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)wgk_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)wgk_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)wgk_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)wgk_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)wgk_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end

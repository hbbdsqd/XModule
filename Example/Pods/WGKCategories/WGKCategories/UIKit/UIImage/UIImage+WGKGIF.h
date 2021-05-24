//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WGKGIF)

+ (UIImage *)wgk_animatedGIFNamed:(NSString *)name;

+ (UIImage *)wgk_animatedGIFWithData:(NSData *)data;

- (UIImage *)wgk_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end

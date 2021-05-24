//
//  UIImage+Blur.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/6/5.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];
@interface UIImage (WGKBlur)

- (UIImage *)wgk_lightImage;
- (UIImage *)wgk_extraLightImage;
- (UIImage *)wgk_darkImage;
- (UIImage *)wgk_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)wgk_blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)wgk_blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)wgk_blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;
@end

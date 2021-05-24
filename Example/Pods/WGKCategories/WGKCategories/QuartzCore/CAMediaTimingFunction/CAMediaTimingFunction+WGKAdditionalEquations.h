//
//  CAMediaTimingFunction+AdditionalEquations.h
//
//  Created by Heiko Dreyer on 02.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//  https://github.com/bfolder/UIView-Visuals

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (WGKAdditionalEquations)


///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInCirc;
+(CAMediaTimingFunction *)wgk_easeOutCirc;
+(CAMediaTimingFunction *)wgk_easeInOutCirc;

///---------------------------------------------------------------------------------------
/// @name Cubic Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInCubic;
+(CAMediaTimingFunction *)wgk_easeOutCubic;
+(CAMediaTimingFunction *)wgk_easeInOutCubic;

///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInExpo;
+(CAMediaTimingFunction *)wgk_easeOutExpo;
+(CAMediaTimingFunction *)wgk_easeInOutExpo;

///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInQuad;
+(CAMediaTimingFunction *)wgk_easeOutQuad;
+(CAMediaTimingFunction *)wgk_easeInOutQuad;

///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInQuart;
+(CAMediaTimingFunction *)wgk_easeOutQuart;
+(CAMediaTimingFunction *)wgk_easeInOutQuart;

///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInQuint;
+(CAMediaTimingFunction *)wgk_easeOutQuint;
+(CAMediaTimingFunction *)wgk_easeInOutQuint;

///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInSine;
+(CAMediaTimingFunction *)wgk_easeOutSine;
+(CAMediaTimingFunction *)wgk_easeInOutSine;

///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)wgk_easeInBack;
+(CAMediaTimingFunction *)wgk_easeOutBack;
+(CAMediaTimingFunction *)wgk_easeInOutBack;

@end

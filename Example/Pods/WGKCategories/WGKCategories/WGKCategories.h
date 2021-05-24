//
//  WGKCategories.h
//  WGKCategories
//
//  Created by Jakey on 16/5/30.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//
#import <UIKit/UIKit.h>


#if __has_include(<WGKCategories/WGKCategories.h>)
FOUNDATION_EXPORT double WGKCategoriesVersionNumber;
//! Project version string for WGKCategories.
FOUNDATION_EXPORT const unsigned char WGKCategoriesVersionString[];
// In this header, you should import all the public headers of your framework using statements like #import <WGKCategories/PublicHeader.h>
#import <WGKCategories/WGKUIKit.h>
#import <WGKCategories/WGKQuartzCore.h>
#import <WGKCategories/WGKCoreData.h>
#import <WGKCategories/WGKFoundation.h>
#import <WGKCategories/WGKMapKit.h>
#import <WGKCategories/WGKCoreLocation.h>
#else
#import "WGKUIKit.h"
#import "WGKQuartzCore.h"
#import "WGKCoreData.h"
#import "WGKFoundation.h"
#import "WGKMapKit.h"
#import "WGKCoreLocation.h"
#endif

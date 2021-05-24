//
//  MKMapView+BetterMaps.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/xjunior/BetterMaps


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (WGKBetterMaps)
- (void)wgk_zoomToFitAnnotationsAnimated:(BOOL)animated;
@end

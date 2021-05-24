//
//  MKMapView+ZoomLevel.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/4/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

// MKMapView+ZoomLevel.m

#import "MKMapView+WGKZoomLevel.h"

#define WGK_MERCATOR_OFFSET 268435456
#define WGK_MERCATOR_RADIUS 85445659.44705395

@implementation MKMapView (WGKZoomLevel)

#pragma mark -
#pragma mark Map conversion methods

- (double)wgk_longitudeToPixelSpaceX:(double)longitude
{
    return round(WGK_MERCATOR_OFFSET + WGK_MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)wgk_latitudeToPixelSpaceY:(double)latitude
{
    return round(WGK_MERCATOR_OFFSET - WGK_MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)wgk_pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - WGK_MERCATOR_OFFSET) / WGK_MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)wgk_pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - WGK_MERCATOR_OFFSET) / WGK_MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)wgk_coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self wgk_longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self wgk_latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self wgk_pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self wgk_pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self wgk_pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self wgk_pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

- (void)wgk_setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self wgk_coordinateSpanWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [self setRegion:region animated:animated];
}

@end

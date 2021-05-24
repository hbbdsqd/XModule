//
//  NSBundle+WGKAppIcon.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSBundle+WGKAppIcon.h"

@implementation NSBundle (WGKAppIcon)
- (NSString*)wgk_appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage*)wgk_appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self wgk_appIconPath]] ;
    return appIcon;
}
@end

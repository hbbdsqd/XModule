//
//  NSFileManager+Paths.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSFileManager+WGKPaths.h"
#include <sys/xattr.h>

@implementation NSFileManager (WGKPaths)
+ (NSURL *)wgk_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)wgk_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)wgk_documentsURL
{
    return [self wgk_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)wgk_documentsPath
{
    return [self wgk_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)wgk_libraryURL
{
    return [self wgk_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)wgk_libraryPath
{
    return [self wgk_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)wgk_cachesURL
{
    return [self wgk_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)wgk_cachesPath
{
    return [self wgk_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)wgk_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)wgk_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.wgk_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}
@end

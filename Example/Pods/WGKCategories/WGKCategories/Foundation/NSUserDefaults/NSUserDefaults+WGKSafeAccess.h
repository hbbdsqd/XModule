//
//  NSUserDefaults+SafeAccess.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (WGKSafeAccess)
+ (NSString *)wgk_stringForKey:(NSString *)defaultName;

+ (NSArray *)wgk_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)wgk_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)wgk_dataForKey:(NSString *)defaultName;

+ (NSArray *)wgk_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)wgk_integerForKey:(NSString *)defaultName;

+ (float)wgk_floatForKey:(NSString *)defaultName;

+ (double)wgk_doubleForKey:(NSString *)defaultName;

+ (BOOL)wgk_boolForKey:(NSString *)defaultName;

+ (NSURL *)wgk_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)wgk_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)wgk_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)wgk_setArcObject:(id)value forKey:(NSString *)defaultName;
@end

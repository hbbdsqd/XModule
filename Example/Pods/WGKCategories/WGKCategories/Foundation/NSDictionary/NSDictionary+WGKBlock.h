//
//  NSDictionary+WGKBlock.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WGKBlock)

#pragma mark - RX
- (void)wgk_each:(void (^)(id k, id v))block;
- (void)wgk_eachKey:(void (^)(id k))block;
- (void)wgk_eachValue:(void (^)(id v))block;
- (NSArray *)wgk_map:(id (^)(id key, id value))block;
- (NSDictionary *)wgk_pick:(NSArray *)keys;
- (NSDictionary *)wgk_omit:(NSArray *)key;

@end

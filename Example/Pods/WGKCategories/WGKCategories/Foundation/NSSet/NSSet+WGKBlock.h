//
//  NSSet+Block.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (WGKBlock)
- (void)wgk_each:(void (^)(id))block;
- (void)wgk_eachWithIndex:(void (^)(id, int))block;
- (NSArray *)wgk_map:(id (^)(id object))block;
- (NSArray *)wgk_select:(BOOL (^)(id object))block;
- (NSArray *)wgk_reject:(BOOL (^)(id object))block;
- (NSArray *)wgk_sort;
- (id)wgk_reduce:(id(^)(id accumulator, id object))block;
- (id)wgk_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end

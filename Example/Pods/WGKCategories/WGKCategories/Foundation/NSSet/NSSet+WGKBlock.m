//
//  NSSet+Block.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSSet+WGKBlock.h"

@implementation NSSet (WGKBlock)
- (void)wgk_each:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj);
    }];
}

- (void)wgk_eachWithIndex:(void (^)(id, int))block {
    __block int counter = 0;
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj, counter);
        counter ++;
    }];
}

- (NSArray *)wgk_map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    
    for (id object in self) {
        id mappedObject = block(object);
        if(mappedObject) {
            [array addObject:mappedObject];
        }
    }
    
    return array;
}

- (NSArray *)wgk_select:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSArray *)wgk_reject:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object) == NO) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSArray *)wgk_sort {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (id)wgk_reduce:(id(^)(id accumulator, id object))block {
    return [self wgk_reduce:nil withBlock:block];
}

- (id)wgk_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block {
    id accumulator = initial;
    
    for(id object in self)
        accumulator = accumulator ? block(accumulator, object) : object;
    
    return accumulator;
}

@end

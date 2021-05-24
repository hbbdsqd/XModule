//
//  NSManagedObject+Extensions.h
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+WGKExtensions.h"

@interface NSManagedObject (WGKExtensions)

+ (id)wgk_create:(NSManagedObjectContext*)context;
+ (id)wgk_create:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context;
+ (id)wgk_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (id)wgk_find:(NSPredicate *)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSArray*)wgk_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray*)wgk_all:(NSPredicate *)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSUInteger)wgk_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)contex;
+ (NSString *)wgk_entityName;
+ (NSError*)wgk_deleteAll:(NSManagedObjectContext*)context;

@end

//
//  NSManagedObjectContext+Extensions.h
//
//  Created by Wess Cope on 9/23/11.
//  Copyright 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSFetchRequest+WGKExtensions.h"

typedef void (^ContextCallback)(NSManagedObjectContext *context);
typedef void (^ContextObjectCallback)(NSManagedObjectContext *context, id object);
typedef void (^ContextObjectsCallback)(NSManagedObjectContext *context, NSArray *objects);


@interface NSManagedObjectContext(WGKExtensions)

#pragma mark - Conveince Property
@property (nonatomic, readonly) NSManagedObjectModel *wgk_objectModel;

#pragma mark - Sync methods
- (NSArray *)wgk_fetchObjectsForEntity:(NSString *)entity;
- (NSArray *)wgk_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate;
- (NSArray *)wgk_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)wgk_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)wgk_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)limit;
- (id)wgk_fetchObjectForEntity:(NSString *)entity;
- (id)wgk_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate;
- (id)wgk_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;
- (id)wgk_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

#pragma mark - Async Methods
- (void)wgk_fetchObjectsForEntity:(NSString *)entity callback:(FetchObjectsCallback)callback;
- (void)wgk_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectsCallback)callback;
- (void)wgk_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback;
- (void)wgk_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback;

- (void)wgk_fetchObjectForEntity:(NSString *)entity callback:(FetchObjectCallback)callback;
- (void)wgk_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectCallback)callback;
- (void)wgk_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback;
- (void)wgk_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback;

- (void)wgk_fetchRequest:(NSFetchRequest *)fetchRequest withCallback:(FetchObjectsCallback)callback;

#pragma mark - Insert New Entity
- (id)wgk_insertEntity:(NSString *)entity;
- (void)wgk_deleteEntity:(NSString *)entity withPredicate:(NSPredicate *)predicate;
@end
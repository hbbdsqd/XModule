//
//  NSManagedObject+Extensions.m
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import "NSManagedObject+WGKExtensions.h"

@implementation NSManagedObject (WGKExtensions)

+ (id)wgk_create:(NSManagedObjectContext*)context {
  return [NSEntityDescription insertNewObjectForEntityForName:[self wgk_entityName] inManagedObjectContext:context];
}

+ (id)wgk_create:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context {
  id instance = [self wgk_create:context];
  [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [instance setValue:obj forKey:key];
  }];
  return instance;
}

+ (id)wgk_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  return [context wgk_fetchObjectForEntity:[self wgk_entityName] predicate:predicate];
}

+ (id)wgk_find:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context {
  return [context wgk_fetchObjectForEntity:[self wgk_entityName] predicate:predicate sortDescriptors:sortDescriptors];
}

+ (NSArray*)wgk_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  return [context wgk_fetchObjectsForEntity:[self wgk_entityName] predicate:predicate];
}

+ (NSArray *)wgk_all:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context {
  return [context wgk_fetchObjectsForEntity:[self wgk_entityName] predicate:predicate sortDescriptors:sortDescriptors];
}

+ (NSUInteger)wgk_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:[self wgk_entityName] inManagedObjectContext:context];
  [request setPredicate:predicate];
  [request setEntity:entity];
  NSError *error = nil;
  return [context countForFetchRequest:request error:&error];
}

+ (NSString *)wgk_entityName {
  return [NSString stringWithCString:object_getClassName(self) encoding:NSASCIIStringEncoding];
}

+ (NSError*)wgk_deleteAll:(NSManagedObjectContext*)context {
  NSFetchRequest * req = [[NSFetchRequest alloc] init];
  [req setEntity:[NSEntityDescription entityForName:[self wgk_entityName] inManagedObjectContext:context]];
  [req setIncludesPropertyValues:NO]; //only fetch the managedObjectID

  NSError * error = nil;
  NSArray * objects = [context executeFetchRequest:req error:&error];
  //error handling goes here
  for (NSManagedObject * obj in objects) {
    [context deleteObject:obj];
  }
  NSError *saveError = nil;
  [context save:&saveError];
  return error;
}

@end

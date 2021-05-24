//
//  GON_NSManagedObjectContext+WGKObjectClear.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (WGKObjectClear)
/* Delete all given objects*/
- (void)wgk_deleteObjects:(id <NSFastEnumeration>)objects;
@end

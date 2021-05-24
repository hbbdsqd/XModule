//
//  NSIndexPath+Offset.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSIndexPath (WGKOffset)
/**
 *  @author WGKCategories
 *
 *  Compute previous row indexpath
 *
 */
- (NSIndexPath *)wgk_previousRow;
/**
 *  @author WGKCategories
 *
 *  Compute next row indexpath
 *
 */
- (NSIndexPath *)wgk_nextRow;
/**
 *  @author WGKCategories
 *
 *  Compute previous item indexpath
 *
 */
- (NSIndexPath *)wgk_previousItem;
/**
 *  @author WGKCategories
 *
 *  Compute next item indexpath
 *
 */
- (NSIndexPath *)wgk_nextItem;
/**
 *  @author WGKCategories
 *
 *  Compute next section indexpath
 *
 */
- (NSIndexPath *)wgk_nextSection;
/**
 *  @author WGKCategories
 *
 *  Compute previous section indexpath
 *
 */
- (NSIndexPath *)wgk_previousSection;

@end

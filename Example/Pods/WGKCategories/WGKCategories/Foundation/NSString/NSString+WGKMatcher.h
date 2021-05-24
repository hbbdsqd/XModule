//
//  NSString+WGKMatcher.h
//  Whyd
//
//  Created by Damien Romito on 29/01/15.
//  Copyright (c) 2015 Damien Romito. All rights reserved.
//
//https://github.com/damienromito/NSString-Matcher
#import <Foundation/Foundation.h>
@interface NSString(WGKMatcher)
- (NSArray *)wgk_matchWithRegex:(NSString *)regex;
- (NSString *)wgk_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)wgk_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)wgk_firstMatchedResultWithRegex:(NSString *)regex;
@end
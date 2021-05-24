//
//  NSString+WGKBase64.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WGKBase64)
+ (NSString *)wgk_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)wgk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)wgk_base64EncodedString;
- (NSString *)wgk_base64DecodedString;
- (NSData *)wgk_base64DecodedData;
@end

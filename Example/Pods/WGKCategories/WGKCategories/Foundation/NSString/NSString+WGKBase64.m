//
//  NSString+WGKBase64.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+WGKBase64.h"
#import "NSData+WGKBase64.h"

@implementation NSString (Base64)
+ (NSString *)wgk_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData wgk_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)wgk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data wgk_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)wgk_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data wgk_base64EncodedString];
}
- (NSString *)wgk_base64DecodedString
{
    return [NSString wgk_stringWithBase64EncodedString:self];
}
- (NSData *)wgk_base64DecodedData
{
    return [NSData wgk_dataWithBase64EncodedString:self];
}
@end

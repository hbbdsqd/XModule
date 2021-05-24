//
//  NSArray+WGKSafeAccess.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSArray+WGKSafeAccess.h"

@implementation NSArray (WGKSafeAccess)
-(id)wgk_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString*)wgk_stringWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)wgk_numberWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)wgk_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self wgk_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)wgk_arrayWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)wgk_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)wgk_integerWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)wgk_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)wgk_boolWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)wgk_int16WithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)wgk_int32WithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)wgk_int64WithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)wgk_charWithIndex:(NSUInteger)index{
    
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)wgk_shortWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)wgk_floatWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)wgk_doubleWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)wgk_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self wgk_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)wgk_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)wgk_pointWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];

    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)wgk_sizeWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];

    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)wgk_rectWithIndex:(NSUInteger)index
{
    id value = [self wgk_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (WGKSafeAccess)
-(void)wgk_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)wgk_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)wgk_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)wgk_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)wgk_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)wgk_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)wgk_addCGFloat:(CGFloat)f
{
   [self addObject:@(f)];
}
-(void)wgk_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)wgk_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)wgk_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)wgk_addSize:(CGSize)o
{
   [self addObject:NSStringFromCGSize(o)];
}
-(void)wgk_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
@end


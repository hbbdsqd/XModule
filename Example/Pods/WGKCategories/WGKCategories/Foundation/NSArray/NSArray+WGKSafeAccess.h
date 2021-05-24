//
//  NSArray+WGKSafeAccess.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (WGKSafeAccess)
-(id)wgk_objectWithIndex:(NSUInteger)index;

- (NSString*)wgk_stringWithIndex:(NSUInteger)index;

- (NSNumber*)wgk_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)wgk_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)wgk_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)wgk_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)wgk_integerWithIndex:(NSUInteger)index;

- (NSUInteger)wgk_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)wgk_boolWithIndex:(NSUInteger)index;

- (int16_t)wgk_int16WithIndex:(NSUInteger)index;

- (int32_t)wgk_int32WithIndex:(NSUInteger)index;

- (int64_t)wgk_int64WithIndex:(NSUInteger)index;

- (char)wgk_charWithIndex:(NSUInteger)index;

- (short)wgk_shortWithIndex:(NSUInteger)index;

- (float)wgk_floatWithIndex:(NSUInteger)index;

- (double)wgk_doubleWithIndex:(NSUInteger)index;

- (NSDate *)wgk_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)wgk_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)wgk_pointWithIndex:(NSUInteger)index;

- (CGSize)wgk_sizeWithIndex:(NSUInteger)index;

- (CGRect)wgk_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(WGKSafeAccess)

-(void)wgk_addObj:(id)i;

-(void)wgk_addString:(NSString*)i;

-(void)wgk_addBool:(BOOL)i;

-(void)wgk_addInt:(int)i;

-(void)wgk_addInteger:(NSInteger)i;

-(void)wgk_addUnsignedInteger:(NSUInteger)i;

-(void)wgk_addCGFloat:(CGFloat)f;

-(void)wgk_addChar:(char)c;

-(void)wgk_addFloat:(float)i;

-(void)wgk_addPoint:(CGPoint)o;

-(void)wgk_addSize:(CGSize)o;

-(void)wgk_addRect:(CGRect)o;
@end

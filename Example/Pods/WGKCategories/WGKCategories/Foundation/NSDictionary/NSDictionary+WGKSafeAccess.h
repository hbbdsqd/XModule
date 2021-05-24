//
//  NSDictionary+WGKSafeAccess.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (WGKSafeAccess)
- (BOOL)wgk_hasKey:(NSString *)key;

- (NSString*)wgk_stringForKey:(id)key;

- (NSNumber*)wgk_numberForKey:(id)key;

- (NSDecimalNumber *)wgk_decimalNumberForKey:(id)key;

- (NSArray*)wgk_arrayForKey:(id)key;

- (NSDictionary*)wgk_dictionaryForKey:(id)key;

- (NSInteger)wgk_integerForKey:(id)key;

- (NSUInteger)wgk_unsignedIntegerForKey:(id)key;

- (BOOL)wgk_boolForKey:(id)key;

- (int16_t)wgk_int16ForKey:(id)key;

- (int32_t)wgk_int32ForKey:(id)key;

- (int64_t)wgk_int64ForKey:(id)key;

- (char)wgk_charForKey:(id)key;

- (short)wgk_shortForKey:(id)key;

- (float)wgk_floatForKey:(id)key;

- (double)wgk_doubleForKey:(id)key;

- (long long)wgk_longLongForKey:(id)key;

- (unsigned long long)wgk_unsignedLongLongForKey:(id)key;

- (NSDate *)wgk_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)wgk_CGFloatForKey:(id)key;

- (CGPoint)wgk_pointForKey:(id)key;

- (CGSize)wgk_sizeForKey:(id)key;

- (CGRect)wgk_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(SafeAccess)

-(void)wgk_setObj:(id)i forKey:(NSString*)key;

-(void)wgk_setString:(NSString*)i forKey:(NSString*)key;

-(void)wgk_setBool:(BOOL)i forKey:(NSString*)key;

-(void)wgk_setInt:(int)i forKey:(NSString*)key;

-(void)wgk_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)wgk_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)wgk_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)wgk_setChar:(char)c forKey:(NSString*)key;

-(void)wgk_setFloat:(float)i forKey:(NSString*)key;

-(void)wgk_setDouble:(double)i forKey:(NSString*)key;

-(void)wgk_setLongLong:(long long)i forKey:(NSString*)key;

-(void)wgk_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)wgk_setSize:(CGSize)o forKey:(NSString*)key;

-(void)wgk_setRect:(CGRect)o forKey:(NSString*)key;
@end

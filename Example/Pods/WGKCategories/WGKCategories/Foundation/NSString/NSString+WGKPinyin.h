//
//  NSString+WGKPinyin.h
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//
// https://github.com/croath/NSString-Pinyin
//  the Chinese Pinyin string of the nsstring

#import <Foundation/Foundation.h>

@interface NSString (WGKPinyin)

- (NSString*)wgk_pinyinWithPhoneticSymbol;
- (NSString*)wgk_pinyin;
- (NSArray*)wgk_pinyinArray;
- (NSString*)wgk_pinyinWithoutBlank;
- (NSArray*)wgk_pinyinInitialsArray;
- (NSString*)wgk_pinyinInitialsString;

@end

//
//  NSString+WGKRemoveEmoji.h
//  NSString+RemoveEmoji
//
//  Created by Jakey on 15/5/13.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (WGKRemoveEmoji)
///移除所有emoji，以“”替换
- (NSString *)wgk_removingEmoji;
///移除所有emoji，以“”替换
- (NSString *)wgk_stringByRemovingEmoji;
///移除所有emoji，以string替换
- (NSString *)wgk_stringByReplaceingEmojiWithString:(NSString*)string;

///字符串是否包含emoji
- (BOOL)wgk_containsEmoji;
///字符串中包含的所有emoji unicode格式
- (NSArray<NSString *>*)wgk_allEmoji;
///字符串中包含的所有emoji
- (NSString *)wgk_allEmojiString;
///字符串中包含的所有emoji rang
- (NSArray<NSString *>*)wgk_allEmojiRanges;

///所有emoji表情
+ (NSString*)wgk_allSystemEmoji;
@end

@interface NSCharacterSet (WGKEmojiCharacterSet)
+ (NSCharacterSet *)wgk_emojiCharacterSet;
@end

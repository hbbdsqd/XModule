//
//  NSString+WGKScore.h
//
//  Created by Nicholas Bruning on 5/12/11.
//  Copyright (c) 2011 Involved Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, NSStringWGKScoreOption) {
    NSStringWGKScoreOptionNone = 1 << 0,
    NSStringWGKScoreOptionFavorSmallerWords = 1 << 1,
    NSStringWGKScoreOptionReducedLongStringPenalty = 1 << 2
};

//模糊匹配字符串 查找某两个字符串的相似程度
@interface NSString (WGKScore)

- (CGFloat)wgk_scoreAgainst:(NSString *)otherString;
- (CGFloat)wgk_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat)wgk_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringWGKScoreOption)options;

@end

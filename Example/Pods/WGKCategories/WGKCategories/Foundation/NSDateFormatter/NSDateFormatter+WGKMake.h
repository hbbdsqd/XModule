//
//  NSDateFormatter+Make.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  mobile.dzone.com/news/ios-threadsafe-date-formatting

#import <Foundation/Foundation.h>

@interface NSDateFormatter (WGKMake)
+(NSDateFormatter *)wgk_dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)wgk_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)wgk_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)wgk_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)wgk_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)wgk_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)wgk_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
@end

//
//  NSDate+Formatter.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Copyright (C) 2013 by Christopher Meyer
//  http://schwiiz.org/
//

#import <Foundation/Foundation.h>

@interface NSDate (WGKFormatter)

+(NSDateFormatter *)wgk_formatter;
+(NSDateFormatter *)wgk_formatterWithoutTime;
+(NSDateFormatter *)wgk_formatterWithoutDate;

-(NSString *)wgk_formatWithUTCTimeZone;
-(NSString *)wgk_formatWithLocalTimeZone;
-(NSString *)wgk_formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)wgk_formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)wgk_formatWithUTCTimeZoneWithoutTime;
-(NSString *)wgk_formatWithLocalTimeZoneWithoutTime;
-(NSString *)wgk_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)wgk_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)wgk_formatWithUTCWithoutDate;
-(NSString *)wgk_formatWithLocalTimeWithoutDate;
-(NSString *)wgk_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)wgk_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)wgk_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)wgk_dateWithSecondsFromNow:(NSInteger)seconds;
- (NSString *)wgk_dateWithFormat:(NSString *)format;
@end

//
//  NSDate+Extension.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WGKExtension)


/**
 * 获取日、月、年、小时、分钟、秒
 */
+ (NSUInteger)wgk_day:(NSDate *)date;
+ (NSUInteger)wgk_month:(NSDate *)date;
+ (NSUInteger)wgk_year:(NSDate *)date;
+ (NSUInteger)wgk_hour:(NSDate *)date;
+ (NSUInteger)wgk_minute:(NSDate *)date;
+ (NSUInteger)wgk_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)wgk_daysInYear;
+ (NSUInteger)wgk_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)wgk_isLeapYear;
+ (BOOL)wgk_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)wgk_weekOfYear;
+ (NSUInteger)wgk_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)wgk_formatYMD;
+ (NSString *)wgk_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)wgk_weeksOfMonth;
+ (NSUInteger)wgk_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)wgk_begindayOfMonth;
+ (NSDate *)wgk_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)wgk_lastdayOfMonth;
+ (NSDate *)wgk_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)wgk_dateAfterDay:(NSUInteger)day;
+ (NSDate *)wgk_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)wgk_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)wgk_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)wgk_offsetYears:(int)numYears;
+ (NSDate *)wgk_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)wgk_offsetMonths:(int)numMonths;
+ (NSDate *)wgk_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)wgk_offsetDays:(int)numDays;
+ (NSDate *)wgk_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)wgk_offsetHours:(int)hours;
+ (NSDate *)wgk_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)wgk_daysAgo;
+ (NSUInteger)wgk_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
+ (NSInteger)wgk_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)wgk_dayFromWeekday;
+ (NSString *)wgk_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)wgk_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)wgk_isToday;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)wgk_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)wgk_stringWithDate:(NSDate *)date format:(NSString *)format;
+ (NSDate *)wgk_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)wgk_daysInMonth:(NSUInteger)month;
+ (NSUInteger)wgk_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)wgk_daysInMonth;
+ (NSUInteger)wgk_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)wgk_timeInfo;
+ (NSString *)wgk_timeInfoWithDate:(NSDate *)date;
+ (NSString *)wgk_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)wgk_ymdFormat;
- (NSString *)wgk_hmsFormat;
- (NSString *)wgk_ymdHmsFormat;
+ (NSString *)wgk_ymdFormat;
+ (NSString *)wgk_hmsFormat;
+ (NSString *)wgk_ymdHmsFormat;

@end

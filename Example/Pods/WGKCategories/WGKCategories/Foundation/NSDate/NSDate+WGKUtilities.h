//
//  NSDate+Utilities.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//
// https://github.com/erica/NSDate-Extensions
#import <Foundation/Foundation.h>
#define WGK_D_MINUTE	60
#define WGK_D_HOUR	3600
#define WGK_D_DAY	86400
#define WGK_D_WEEK	604800
#define WGK_D_YEAR	31556926
@interface NSDate (WGKUtilities)
+ (NSCalendar *)wgk_currentCalendar; // avoid bottlenecks
#pragma mark ---- Decomposing dates 分解的日期
@property (readonly) NSInteger wgk_nearestHour;
@property (readonly) NSInteger wgk_hour;
@property (readonly) NSInteger wgk_minute;
@property (readonly) NSInteger wgk_seconds;
@property (readonly) NSInteger wgk_day;
@property (readonly) NSInteger wgk_month;
@property (readonly) NSInteger wgk_week;
@property (readonly) NSInteger wgk_weekday;
@property (readonly) NSInteger wgk_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger wgk_year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *wgk_shortString;
@property (nonatomic, readonly) NSString *wgk_shortDateString;
@property (nonatomic, readonly) NSString *wgk_shortTimeString;
@property (nonatomic, readonly) NSString *wgk_mediumString;
@property (nonatomic, readonly) NSString *wgk_mediumDateString;
@property (nonatomic, readonly) NSString *wgk_mediumTimeString;
@property (nonatomic, readonly) NSString *wgk_longString;
@property (nonatomic, readonly) NSString *wgk_longDateString;
@property (nonatomic, readonly) NSString *wgk_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)wgk_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)wgk_stringWithFormat:(NSString *)format;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)wgk_dateTomorrow;
///昨天
+ (NSDate *)wgk_dateYesterday;
///今天后几天
+ (NSDate *)wgk_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)wgk_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)wgk_dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)wgk_dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)wgk_dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)wgk_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)wgk_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)wgk_isToday;
///是否是明天
- (BOOL)wgk_isTomorrow;
///是否是昨天
- (BOOL)wgk_isYesterday;

///是否是同一周
- (BOOL)wgk_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)wgk_isThisWeek;
///是否是本周的下周
- (BOOL)wgk_isNextWeek;
///是否是本周的上周
- (BOOL)wgk_isLastWeek;

///是否是同一月
- (BOOL)wgk_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)wgk_isThisMonth;
///是否是本月的下月
- (BOOL)wgk_isNextMonth;
///是否是本月的上月
- (BOOL)wgk_isLastMonth;

///是否是同一年
- (BOOL)wgk_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)wgk_isThisYear;
///是否是今年的下一年
- (BOOL)wgk_isNextYear;
///是否是今年的上一年
- (BOOL)wgk_isLastYear;

///是否提前aDate
- (BOOL)wgk_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)wgk_isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)wgk_isInFuture;
///是否晚是过去
- (BOOL)wgk_isInPast;


///是否是工作日
- (BOOL)wgk_isTypicallyWorkday;
///是否是周末
- (BOOL)wgk_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年
- (NSDate *)wgk_dateByAddingYears:(NSInteger)dYears;
///减少dYears年
- (NSDate *)wgk_dateBySubtractingYears:(NSInteger)dYears;
///增加dMonths月
- (NSDate *)wgk_dateByAddingMonths:(NSInteger)dMonths;
///减少dMonths月
- (NSDate *)wgk_dateBySubtractingMonths:(NSInteger)dMonths;
///增加dDays天
- (NSDate *)wgk_dateByAddingDays:(NSInteger)dDays;
///减少dDays天
- (NSDate *)wgk_dateBySubtractingDays:(NSInteger)dDays;
///增加dHours小时
- (NSDate *)wgk_dateByAddingHours:(NSInteger)dHours;
///减少dHours小时
- (NSDate *)wgk_dateBySubtractingHours:(NSInteger)dHours;
///增加dMinutes分钟
- (NSDate *)wgk_dateByAddingMinutes:(NSInteger)dMinutes;
///减少dMinutes分钟
- (NSDate *)wgk_dateBySubtractingMinutes:(NSInteger)dMinutes;


#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)wgk_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)wgk_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)wgk_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)wgk_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)wgk_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)wgk_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)wgk_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)wgk_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)wgk_distanceYearsToDate:(NSDate *)anotherDate;
@end

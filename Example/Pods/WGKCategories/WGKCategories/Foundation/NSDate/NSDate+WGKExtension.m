//
//  NSDate+Extension.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/632840804/HYBNSDateExtension

#import "NSDate+WGKExtension.h"

@implementation NSDate (WGKExtension)

+ (NSUInteger)wgk_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)wgk_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)wgk_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)wgk_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)wgk_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)wgk_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)wgk_daysInYear {
    return [NSDate wgk_daysInYear:self];
}

+ (NSUInteger)wgk_daysInYear:(NSDate *)date {
    return [self wgk_isLeapYear:date] ? 366 : 365;
}

- (BOOL)wgk_isLeapYear {
    return [NSDate wgk_isLeapYear:self];
}

+ (BOOL)wgk_isLeapYear:(NSDate *)date {
    NSUInteger year = [NSDate wgk_year:date];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)wgk_formatYMD {
    return [NSDate wgk_formatYMD:self];
}

+ (NSString *)wgk_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%zd-%zd-%zd",[NSDate wgk_year:date],[NSDate wgk_month:date], [NSDate wgk_day:date]];
}

- (NSUInteger)wgk_weeksOfMonth {
    return [NSDate wgk_weeksOfMonth:self];
}

+ (NSUInteger)wgk_weeksOfMonth:(NSDate *)date {
    return [[date wgk_lastdayOfMonth] wgk_weekOfYear] - [[date wgk_begindayOfMonth] wgk_weekOfYear] + 1;
}

- (NSUInteger)wgk_weekOfYear {
    return [NSDate wgk_weekOfYear:self];
}

+ (NSUInteger)wgk_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [NSDate wgk_year:date];
    
//    NSDate *lastdate = [date wgk_lastdayOfMonth];
    
    for (i = 1;[NSDate wgk_year: [date wgk_dateAfterDay:-7 * i]] == year; i++) {
        
    }
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"'公元前/后:'G  '年份:'u'='yyyy'='yy '季度:'q'='qqq'='qqqq '月份:'M'='MMM'='MMMM '今天是今年第几周:'w '今天是本月第几周:'W  '今天是今天第几天:'D '今天是本月第几天:'d '星期:'c'='ccc'='cccc '上午/下午:'a '小时:'h'='H '分钟:'m '秒:'s '毫秒:'SSS  '这一天已过多少毫秒:'A  '时区名称:'zzzz'='vvvv '时区编号:'Z "];
//    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    return i;
}

- (NSDate *)wgk_dateAfterDay:(NSUInteger)day {
    return [NSDate wgk_dateAfterDate:self day:day];
}

+ (NSDate *)wgk_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)wgk_dateAfterMonth:(NSUInteger)month {
    return [NSDate wgk_dateAfterDate:self month:month];
}

+ (NSDate *)wgk_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)wgk_begindayOfMonth {
    return [NSDate wgk_begindayOfMonth:self];
}

+ (NSDate *)wgk_begindayOfMonth:(NSDate *)date {
    return [self wgk_dateAfterDate:date day:-[NSDate wgk_day:date] + 1];
}

- (NSDate *)wgk_lastdayOfMonth {
    return [NSDate wgk_lastdayOfMonth:self];
}

+ (NSDate *)wgk_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self wgk_begindayOfMonth:date];
    return [[lastDate wgk_dateAfterMonth:1] wgk_dateAfterDay:-1];
}

- (NSUInteger)wgk_daysAgo {
    return [NSDate wgk_daysAgo:self];
}

+ (NSUInteger)wgk_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

+ (NSInteger)wgk_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)wgk_dayFromWeekday {
    return [NSDate wgk_dayFromWeekday:self];
}

+ (NSString *)wgk_dayFromWeekday:(NSDate *)date {
    switch([NSDate wgk_weekday: date]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)wgk_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)wgk_isToday {
    return [self wgk_isSameDay:[NSDate date]];
}

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
+ (NSString *)wgk_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)wgk_stringWithDate:(NSDate *)date format:(NSString *)format {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:date];
    
    return retStr;
}

+ (NSDate *)wgk_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)wgk_daysInMonth:(NSUInteger)month {
    return [NSDate wgk_daysInMonth:self month:month];
}

+ (NSUInteger)wgk_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date wgk_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)wgk_daysInMonth {
    return [NSDate wgk_daysInMonth:self];
}

+ (NSUInteger)wgk_daysInMonth:(NSDate *)date {
    return [self wgk_daysInMonth:date month:[NSDate wgk_month:date]];
}

- (NSString *)wgk_timeInfo {
    return [NSDate wgk_timeInfoWithDate:self];
}

+ (NSString *)wgk_timeInfoWithDate:(NSDate *)date {
    return [self wgk_timeInfoWithDateString:[self wgk_stringWithDate:date format:[self wgk_ymdHmsFormat]]];
}

+ (NSString *)wgk_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self wgk_dateWithString:dateString format:[self wgk_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([NSDate wgk_month:curDate] - [NSDate wgk_month:date]);
    int year = (int)([NSDate wgk_year:curDate] - [NSDate wgk_year:date]);
    int day = (int)([NSDate wgk_day:curDate] - [NSDate wgk_day:date]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
//        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
        return retTime < 1.0 ? @"刚刚" : [NSString stringWithFormat:@"%.0f分钟前", retTime];

    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [NSDate wgk_month:curDate] == 1 && [NSDate wgk_month:date] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self wgk_daysInMonth:date month:[NSDate wgk_month:date]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[NSDate wgk_day:curDate] + (totalDays - (int)[NSDate wgk_day:date]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[NSDate wgk_month:curDate];
            int preMonth = (int)[NSDate wgk_month:date];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)wgk_ymdFormat {
    return [NSDate wgk_ymdFormat];
}

- (NSString *)wgk_hmsFormat {
    return [NSDate wgk_hmsFormat];
}

- (NSString *)wgk_ymdHmsFormat {
    return [NSDate wgk_ymdHmsFormat];
}

+ (NSString *)wgk_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)wgk_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)wgk_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self wgk_ymdFormat], [self wgk_hmsFormat]];
}

- (NSDate *)wgk_offsetYears:(int)numYears {
    return [NSDate wgk_offsetYears:numYears fromDate:self];
}

+ (NSDate *)wgk_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wgk_offsetMonths:(int)numMonths {
    return [NSDate wgk_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)wgk_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wgk_offsetDays:(int)numDays {
    return [NSDate wgk_offsetDays:numDays fromDate:self];
}

+ (NSDate *)wgk_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wgk_offsetHours:(int)hours {
    return [NSDate wgk_offsetHours:hours fromDate:self];
}

+ (NSDate *)wgk_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end

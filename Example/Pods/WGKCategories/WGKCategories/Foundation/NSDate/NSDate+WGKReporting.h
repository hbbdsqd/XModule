//
// NSDate+Reporting.h
//
// Created by Mel Sampat on 5/11/12.
// Copyright (c) 2012 Mel Sampat.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (WGKReporting)

// Return a date with a specified year, month and day.
+ (NSDate *)wgk_dateWithYear:(int)year month:(int)month day:(int)day;

// Return midnight on the specified date.
+ (NSDate *)wgk_midnightOfDate:(NSDate *)date;

// Return midnight today.
+ (NSDate *)wgk_midnightToday;

// Return midnight tomorrow.
+ (NSDate *)wgk_midnightTomorrow;

// Returns a date that is exactly 1 day after the specified date. Does *not*
// zero out the time components. For example, if the specified date is
// April 15 2012 10:00 AM, the return value will be April 16 2012 10:00 AM.
+ (NSDate *)wgk_oneDayAfter:(NSDate *)date;

// Returns midnight of the first day of the current, previous or next Month.
// Note: firstDayOfNextMonth returns midnight of the first day of next month,
// which is effectively the same as the "last moment" of the current month.
+ (NSDate *)wgk_firstDayOfCurrentMonth;
+ (NSDate *)wgk_firstDayOfPreviousMonth;
+ (NSDate *)wgk_firstDayOfNextMonth;

// Returns midnight of the first day of the current, previous or next Quarter.
// Note: firstDayOfNextQuarter returns midnight of the first day of next quarter,
// which is effectively the same as the "last moment" of the current quarter.
+ (NSDate *)wgk_firstDayOfCurrentQuarter;
+ (NSDate *)wgk_firstDayOfPreviousQuarter;
+ (NSDate *)wgk_firstDayOfNextQuarter;

// Returns midnight of the first day of the current, previous or next Year.
// Note: firstDayOfNextYear returns midnight of the first day of next year,
// which is effectively the same as the "last moment" of the current year.
+ (NSDate *)wgk_firstDayOfCurrentYear;
+ (NSDate *)wgk_firstDayOfPreviousYear;
+ (NSDate *)wgk_firstDayOfNextYear;


- (NSDate *)wgk_dateFloor;
- (NSDate *)wgk_dateCeil;

- (NSDate *)wgk_startOfWeek;
- (NSDate *)wgk_endOfWeek;

- (NSDate *)wgk_startOfMonth;
- (NSDate *)wgk_endOfMonth;

- (NSDate *)wgk_startOfYear;
- (NSDate *)wgk_endOfYear;

- (NSDate *)wgk_previousDay;
- (NSDate *)wgk_nextDay;

- (NSDate *)wgk_previousWeek;
- (NSDate *)wgk_nextWeek;

- (NSDate *)wgk_previousMonth;
- (NSDate *)wgk_previousMonth:(NSUInteger) monthsToMove;
- (NSDate *)wgk_nextMonth;
- (NSDate *)wgk_nextMonth:(NSUInteger) monthsToMove;

#ifdef DEBUG
// For testing only. A helper function to format and display a date
// with an optional comment. For example:
//     NSDate *test = [NSDate firstDayOfCurrentMonth];
//     [test logWithComment:@"First day of current month: "];
- (void)wgk_logWithComment:(NSString *)comment;
#endif

@end

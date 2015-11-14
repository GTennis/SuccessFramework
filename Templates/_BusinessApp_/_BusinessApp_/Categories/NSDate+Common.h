//
//  NSDate+Common.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/5/13.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)

+ (void)setLocaleForLanguage:(NSString *)language;

- (NSInteger)monthTotalDays:(NSDate *)date;
- (NSInteger)previousMonthTotalDays:(NSDate *)date;
- (NSString *)previousMonth:(NSDate *)date;
- (NSString *)nextMonth:(NSDate *)date;
- (NSString *)weekDayShortName:(NSDate *)date;
- (NSString *)weekDayLongName:(NSDate *)date;
- (NSInteger)weekDay:(NSDate *)date;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSString *)timeFromDate;
- (NSString *)localTimeFromDate;
- (NSString *)stringWithoutDayFromDate:(NSDate *)date;
- (NSString *)year:(NSDate *)date;
- (NSString *)month:(NSDate *)date;
- (NSString *)monthFullName:(NSDate *)date;
- (NSString *)day:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateString;
- (NSString *)dateShortStringFromDate:(NSDate *)date;
- (NSDate *)dateFromYear:(NSString *)year month:(NSString *)month day:(NSString *)day;
- (NSDate *)dateFromYear:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute;
- (NSDate *)dateFromIntegersYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
- (NSDate *)dateWithMidnightTimeFromDate:(NSDate *)date;
- (NSDate *)monthFirstDayDate:(NSDate *)date;
- (NSDate *)monthLastDayDate:(NSDate *)date;
- (NSDate *)dateWithLocalTime;
+ (NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate;
+ (BOOL)date:(NSDate *)date1 isLaterThanOrEqualTo:(NSDate *)date2;
+ (BOOL)date:(NSDate *)date1 isEarlierThanOrEqualTo:(NSDate*)date2;
+ (BOOL)date:(NSDate *)date1 isLaterThan:(NSDate*)date2;
+ (BOOL)date:(NSDate *)date1 isEarlierThan:(NSDate*)date2;
+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
+ (BOOL)isSameMonthWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
- (NSDate *)dateFromDate:(NSDate *)date byAddingNumberOfDays:(NSInteger)dayNum;
- (NSInteger)timeZoneOffsetFromUTC;
- (NSString *)currentTimeZone;
- (void)calculateSiblingMonthsForDate:(NSDate *)date siblingLength:(NSInteger)months earlierDate:(NSDate **)earlierDate laterDate:(NSDate **)laterDate;
- (NSDate *)dateWithoutTime:(NSDate *)date;
- (NSString *)dateStringFromDate:(NSDate *)date;
- (NSString *)gmtDateTimeString:(NSDate *)date;
+ (NSInteger)hoursBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;
+ (NSInteger)minutesBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;
+ (NSInteger)secondsBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;

#pragma mark - with custom date format -

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

@end

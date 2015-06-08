//
//  NSDate+Common.m
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

#import "NSDate+Common.h"

#define kLocaleEnglish @"en_GB"
#define kLocaleGerman @"de_DE"

#define kDateFormatForParsingDates @"yyyy-M-d'T'H:mm:ssZ"

@implementation NSDate (Common)

// This formatter is used for displaying dates relative to user's location and device setttings
static NSDateFormatter *_dateFormatterForViewingDates = nil;

// This formatter will be used for parsing dates only
static NSDateFormatter *_dateFormatterForParsingDates = nil;

// Will be called when using instance methods
- (void)initialize {
    
    if (!_dateFormatterForParsingDates) {
        
        _dateFormatterForParsingDates = [[NSDateFormatter alloc] init];
        
        // All the dates received from the backend are expected to be UTC/GMT
        // Therefore manually setting time zone to 0
        _dateFormatterForParsingDates.TimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        
        // Need to set this workaround. Otherwise parsing date from string (dateFromString) will return nil if user has turned off 24-Hour time in Time and Date settings.
        // Solution used from: http://stackoverflow.com/questions/6613110/what-is-the-best-way-to-deal-with-the-nsdateformatter-locale-feature
        _dateFormatterForParsingDates.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    
    if (!_dateFormatterForViewingDates) {
        
        _dateFormatterForViewingDates = [[NSDateFormatter alloc] init];
        
        // This will set formatter to relative time zone to user's zone
        _dateFormatterForViewingDates.TimeZone = [NSTimeZone systemTimeZone/*localTimeZone*/];
        
    }
}

// Will be called when using static methods
+ (void)initialize {
    
    if (!_dateFormatterForParsingDates) {
        
        _dateFormatterForParsingDates = [[NSDateFormatter alloc] init];
        
        // All the dates received from the backend are expected to be UTC/GMT
        // Therefore manually setting time zone to 0
        _dateFormatterForParsingDates.TimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        
        // Need to set this workaround. Otherwise parsing date from string (dateFromString) will return nil if user has turned off 24-Hour time in Time and Date settings.
        // Solution used from: http://stackoverflow.com/questions/6613110/what-is-the-best-way-to-deal-with-the-nsdateformatter-locale-feature
        _dateFormatterForParsingDates.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    
    if (!_dateFormatterForViewingDates) {
        
        _dateFormatterForViewingDates = [[NSDateFormatter alloc] init];
        
        // This will set formatter to relative time zone to user's zone
        _dateFormatterForViewingDates.TimeZone = [NSTimeZone systemTimeZone/*localTimeZone*/];
        
    }
}

+ (void)setLocaleForLanguage:(NSString *)language {
    
    NSString *newLocale = nil;
    
    if ([language isEqualToString:kLanguageEnglish]) {
        
        newLocale = kLocaleEnglish;
        
    } else if ([language isEqualToString:kLanguageGerman]) {
        
        newLocale = kLocaleGerman;
        
    } else {
        
        newLocale = kLocaleEnglish;
    }
    
    _dateFormatterForViewingDates.locale = [[NSLocale alloc] initWithLocaleIdentifier:newLocale];
}

- (NSInteger)previousMonthTotalDays:(NSDate *)date {
    
    NSString *year = [self year:date];
    NSString *month = [self month:date];
    NSDate *firstMonthDay = [self dateFromYear:year month:month day:@"1"];
    NSDate *previousMonthDate = [firstMonthDay dateByAddingTimeInterval:-1];
    
    NSInteger totalDays = [self monthTotalDays:previousMonthDate];
    
    return totalDays;
}

- (NSString *)previousMonth:(NSDate *)date {
    
    NSInteger month = [[self month:date] integerValue];
    month--;
    if (month == 0) {
        
        month = 12;
    }
    
    NSString *monthString = [NSString stringWithFormat:@"%ld", (long)month];
    
    return monthString;
}

- (NSString *)nextMonth:(NSDate *)date {
    
    NSInteger month = [[self month:date] integerValue];
    month++;
    if (month == 13) {
        
        month = 1;
    }
    
    NSString *monthString = [NSString stringWithFormat:@"%ld", (long)month];
    
    return monthString;
}

- (NSInteger)monthTotalDays:(NSDate *)date {
    
    NSDate *monthLastDayDate = [self monthLastDayDate:date];
    NSString *totalDays = [self day:monthLastDayDate];
    
    return [totalDays integerValue];
}

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    
    NSString *dateString = nil;
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.TimeZone = [NSTimeZone systemTimeZone/*localTimeZone*/];
        _dateFormatterForViewingDates.dateFormat = format;
        dateString = [_dateFormatterForViewingDates stringFromDate:date];
    }
    return dateString;
}

- (NSString *)stringFromDate:(NSDate *)date {
    
    NSString *dateString = nil;
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.dateStyle = kCFDateFormatterShortStyle;
        _dateFormatterForViewingDates.TimeZone = [NSTimeZone systemTimeZone/*localTimeZone*/];
        dateString = [_dateFormatterForViewingDates stringFromDate:date];
        _dateFormatterForViewingDates.dateStyle = kCFDateFormatterNoStyle;
    }
    return dateString;
}

- (NSString *)timeFromDate {
    
    NSString *timeString = nil;
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.timeStyle = kCFDateFormatterShortStyle;
        _dateFormatterForViewingDates.TimeZone = [NSTimeZone systemTimeZone/*localTimeZone*/];
        timeString = [_dateFormatterForViewingDates stringFromDate:self];
        _dateFormatterForViewingDates.timeStyle = kCFDateFormatterNoStyle;
    }
    return timeString;
}

- (NSString *)localTimeFromDate {
    
    NSString *timeString = [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    
    return timeString;
}

- (NSString *)stringWithoutDayFromDate:(NSDate *)date {
    
    NSString *dateString = [self stringFromDate:date format:@"LLLL yyyy"];
    return dateString;
}

- (NSString *)year:(NSDate *)date {
    
    NSString *year = [self stringFromDate:date format:@"yyyy"];
    return year;
}

- (NSString *)month:(NSDate *)date {
    
    NSString *month = [self stringFromDate:date format:@"M"];
    return month;
}

- (NSString *)monthFullName:(NSDate *)date {
    
    NSString *month = [self stringFromDate:date format:@"MMMM"];
    return month;
}

- (NSString *)day:(NSDate *)date {
    
    NSString *day = [self stringFromDate:date format:@"d"];
    return day;
}

- (NSInteger)weekDay:(NSDate *)date {
    
    NSString *weekDay = [self stringFromDate:date format:@"e"];
    return [weekDay integerValue];
}

- (NSString *)weekDayShortName:(NSDate *)date {
    
    NSString *weekDay = [self stringFromDate:date format:@"EEE"];
    return weekDay;
}

- (NSString *)weekDayLongName:(NSDate *)date {
    
    NSString *weekDay = [self stringFromDate:date format:@"EEEE"];
    return weekDay;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    
    /* NSLog and debugger always shows NSDate objects in 0 GMT.
     When creating date from string without time, date is created with current time zone.:
     for example string "2013-02-21" will be converted to 2013-02-21 00:00:00 +2 GMT (when using in Lithuania).
     so, the real date object will be shown as 2013-02-20 22:00:00 +0 GMT when printing and using this date because it will subtract 2 GMT hours and show the date in 0 GMT
     */
    
    NSDateFormatter *df = _dateFormatterForParsingDates;
    [df setDateFormat:kDateFormatForParsingDates];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *result = [df dateFromString: dateString];
    
    return result;
}

- (NSString *)dateShortStringFromDate:(NSDate *)date {
    
    NSString *formattedDateString = nil;
    
    @synchronized(_dateFormatterForViewingDates)
    {
        formattedDateString = [self stringFromDate:date format:@"EEE d MMM"];
    }
    return formattedDateString;
}

- (NSDate *)dateFromYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    
    NSString *formattedDate = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    
    NSDate *date = nil;
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.dateFormat = @"yyyy-M-d";
        date = [_dateFormatterForViewingDates dateFromString:formattedDate];
    }
    return date;
}

- (NSDate *)dateFromYear:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute {
    
    NSString *formattedDate = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", year, month, day, hour, minute];
    
    NSDate *date = nil;
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.dateFormat = @"yyyy-M-d H:m";
        date = [_dateFormatterForViewingDates dateFromString:formattedDate];
    }
    return date;
}

- (NSDate *)dateFromIntegersYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    
    NSString *formattedDate = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld", (long)year, (long)month, (long)day, (long)hour, (long)minute];
    
    NSDate *date = nil;
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.dateFormat = @"yyyy-M-d H:m";
        date = [_dateFormatterForViewingDates dateFromString:formattedDate];
    }
    return date;
}

// Removes time from date (sets time to 00:00)
- (NSDate *)dateWithMidnightTimeFromDate:(NSDate *)date {
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:flags fromDate:date];
    NSDate *dateAtMidnight = [calendar dateFromComponents:components];
    
    return dateAtMidnight;
}

- (NSDate *)monthFirstDayDate:(NSDate *)date {
    
    NSString *year = [self year:date];
    NSString *month = [self month:date];
    
    NSDate *monthFirstDayDate = [self dateFromYear:year month:month day:@"1"];
    return monthFirstDayDate;
}

- (NSDate *)monthLastDayDate:(NSDate *)date {
    
    NSDate *monthFirstDayDate = [self monthFirstDayDate:date];
    
    // add 31 days
    NSDate *nextMonthDate = [monthFirstDayDate dateByAddingTimeInterval:2764800];
    NSString *year = [self year:nextMonthDate];
    NSString *month = [self month:nextMonthDate];
    
    NSDate *nextMonthFirstDayDate = [self dateFromYear:year month:month day:@"1"];
    NSDate *lastDayDate = [nextMonthFirstDayDate dateByAddingTimeInterval:-1];
    
    return lastDayDate;
}

- (NSDate *)dateWithLocalTime {
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: currentDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: currentDate];
}

+ (NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger startDay=[calendar ordinalityOfUnit:NSDayCalendarUnit
                                           inUnit: NSEraCalendarUnit forDate:startDate];
    NSInteger endDay=[calendar ordinalityOfUnit:NSDayCalendarUnit
                                         inUnit: NSEraCalendarUnit forDate:endDate];
    return endDay-startDay;
}


+ (BOOL)date:(NSDate *)date1 isLaterThanOrEqualTo:(NSDate *)date2 {
    
    return !([date1 compare:date2] == NSOrderedAscending);
}

+ (BOOL)date:(NSDate *)date1 isEarlierThanOrEqualTo:(NSDate*)date2 {
    
    return !([date1 compare:date2] == NSOrderedDescending);
}

+ (BOOL)date:(NSDate *)date1 isLaterThan:(NSDate*)date2 {
    
    return ([date1 compare:date2] == NSOrderedDescending);
}

+ (BOOL)date:(NSDate *)date1 isEarlierThan:(NSDate*)date2 {
    
    return ([date1 compare:date2] == NSOrderedAscending);
}

+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date2];
    
    BOOL result = [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
    
    return result;
}

+ (BOOL)isSameMonthWithDate1:(NSDate*)date1 date2:(NSDate*)date2 {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date2];
    
    BOOL result = [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
    
    return result;
}

- (NSDate *)dateFromDate:(NSDate *)date byAddingNumberOfDays:(NSInteger)dayNum {
    
    NSInteger numberOfSecondsInDay = 60 * 60 * 24 * dayNum;
    NSDate *result = [NSDate dateWithTimeInterval:numberOfSecondsInDay sinceDate:date];
    
    return result;
}

- (NSInteger)timeZoneOffsetFromUTC {
    
    NSInteger offset = ([[NSTimeZone systemTimeZone/*localTimeZone*/] secondsFromGMT]) / 3600;
    return offset;
}

- (NSString *)currentTimeZone {
    
    NSString *timeZoneString = [NSTimeZone systemTimeZone].name;
    timeZoneString = [timeZoneString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    return timeZoneString;
}

// Calculates sibling dates for the specified reference dates
- (void)calculateSiblingMonthsForDate:(NSDate *)date siblingLength:(NSInteger)months earlierDate:(NSDate **)earlierDate laterDate:(NSDate **)laterDate {
    
    if (date != nil)
    {
        // Calculate previous and next months:
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        if (earlierDate != nil)
        {
            [dateComponents setMonth:-months];
            *earlierDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
        }
        if (laterDate != nil)
        {
            [dateComponents setMonth:months];
            *laterDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
        }
        //[calendar release];
        //[dateComponents release];
    }
}

- (NSDate *)dateWithoutTime:(NSDate *)date {
    
    NSString *year = [self year:date];
    NSString *month = [self month:date];
    NSString *day = [self day:date];
    
    NSDate *dateWithoutTime = [self dateFromYear:year month:month day:day];
    
    return dateWithoutTime;
}

- (NSString *)dateStringFromDate:(NSDate *)date {
    
    
    NSString *newDateString = nil;
    
    @synchronized(_dateFormatterForViewingDates)
    {
        _dateFormatterForViewingDates.dateFormat = @"yyyy-MM-dd";
        newDateString = [_dateFormatterForViewingDates stringFromDate:date];
    }
    
    return newDateString;
}

- (NSString *)gmtDateTimeString:(NSDate *)date {
    
    NSString *newDateString = nil;
    
    @synchronized(_dateFormatterForParsingDates)
    {
        _dateFormatterForParsingDates.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        newDateString = [_dateFormatterForParsingDates stringFromDate:date];
    }
    
    return newDateString;
}

+ (NSInteger)hoursBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSHourCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:startDate
                                                  toDate:endDate options:0];
    NSInteger hours = [components hour];
    return hours;
}

+ (NSInteger)minutesBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitMinute;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:startDate
                                                  toDate:endDate options:0];
    NSInteger minutes = [components minute];
    return minutes;
}

+ (NSInteger)secondsBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitSecond;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:startDate
                                                  toDate:endDate options:0];
    NSInteger seconds = [components second];
    return seconds;
}

@end

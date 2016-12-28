//
//  Date+Common.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 26/10/2016.
//  Copyright © 2016 Gytenis Mikulėnas 
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

import UIKit

let kLocaleEnglish = "en_GB"
let kLocaleGerman = "de_DE"

let kDateFormatForParsingDates = "yyyy-M-d'T'H:mm:ssZ"

// This formatter is used for displaying dates relative to user's location and device setttings
var _dateFormatterForViewingDates: DateFormatter? = nil

// This formatter will be used for parsing dates only
var _dateFormatterForParsingDates: DateFormatter? = nil

let dateConfigInit = {
    
    if (_dateFormatterForParsingDates == nil) {
        
        _dateFormatterForParsingDates = DateFormatter()
        
        // All the dates received from the backend are expected to be UTC/GMT
        // Therefore manually setting time zone to 0
        _dateFormatterForParsingDates?.timeZone = TimeZone.init(secondsFromGMT:0)
        
        // Need to set this workaround. Otherwise parsing date from string (dateFromString) will return nil if user has turned off 24-Hour time in Time and Date settings.
        // Solution used from: http://stackoverflow.com/questions/6613110/what-is-the-best-way-to-deal-with-the-nsdateformatter-locale-feature
        _dateFormatterForParsingDates?.locale = Locale.init(identifier:"en_US_POSIX")
    }
    
    if (_dateFormatterForViewingDates == nil) {
        
        _dateFormatterForViewingDates = DateFormatter()
        
        // This will set formatter to relative time zone to user's zone
        _dateFormatterForViewingDates?.timeZone = TimeZone.current
    }
}

// On how to use init for static class methods
// http://stackoverflow.com/a/24137213/597292

extension Date {

    static func setLocale(language: String) {
        
        var newLocale: String?
        
        if (language.isEqual(ConstLangKeys.langEnglish)) {
            
            newLocale = kLocaleEnglish
            
        } else if (language.isEqual(ConstLangKeys.langGerman)) {
            
            newLocale = kLocaleGerman
            
        } else {
            
            newLocale = kLocaleEnglish
        }
        
        _dateFormatterForViewingDates?.locale = Locale.init(identifier:newLocale!)
    }
    
    // MARK: Retrieving from date
    
    func stringFromDate(format: String) -> String? {
        
        var dateString: String?
        
        synchronized(obj: _dateFormatterForViewingDates!) {
            
            _dateFormatterForViewingDates!.timeZone = TimeZone.current
            _dateFormatterForViewingDates!.dateFormat = format;
            dateString = _dateFormatterForViewingDates!.string(from: self)
        }
        
        return dateString
    }
    
    func stringFromDate() -> String? {
        
        var dateString: String?
        
        synchronized(obj: _dateFormatterForViewingDates!) {
            
            _dateFormatterForViewingDates!.dateStyle = DateFormatter.Style.short
            _dateFormatterForViewingDates!.timeZone = TimeZone.current
            dateString = _dateFormatterForViewingDates!.string(from: self)
            _dateFormatterForViewingDates!.dateStyle = DateFormatter.Style.none
        }
        
        return dateString
    }
    
    func shortStringFromDate() -> String? {
        
        var dateString: String?
        
        synchronized(obj: _dateFormatterForViewingDates!) {
            
            dateString = self.stringFromDate(format:"EEE d MMM")
        }
        
        return dateString
    }
    
    
    
    /*- (NSString *)dateShortStringFromDate:(NSDate *)date;
    - (NSString *)timeFromDate;
    - (NSString *)localTimeFromDate;
    - (NSString *)stringWithoutDayFromDate:(NSDate *)date;
    - (NSString *)year:(NSDate *)date;
    - (NSString *)month:(NSDate *)date;
    - (NSString *)monthFullName:(NSDate *)date;
    - (NSString *)day:(NSDate *)date;
    - (NSString *)previousMonth:(NSDate *)date;
    - (NSString *)nextMonth:(NSDate *)date;
    - (NSString *)weekDayShortName:(NSDate *)date;
    - (NSString *)weekDayLongName:(NSDate *)date;
    - (NSString *)gmtDateTimeString:(NSDate *)date;
    - (NSString *)localDate;
    - (NSString *)localTime;
    - (NSString *)currentTimeZone;
    
    - (NSInteger)timeZoneOffsetFromUTC;
    + (NSInteger)daysWithinEraFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
    + (NSInteger)hoursBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;
    + (NSInteger)minutesBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;
    + (NSInteger)secondsBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;
    
    - (NSInteger)monthTotalDays:(NSDate *)date;
    - (NSInteger)previousMonthTotalDays:(NSDate *)date;
    - (NSInteger)weekDay:(NSDate *)date;
    
    
    // MARK: Creating new date
    
    + (NSDate *)dateFromString:(NSString *)dateString;
    + (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)formatString;
    - (NSDate *)dateFromYear:(NSString *)year month:(NSString *)month day:(NSString *)day;
    - (NSDate *)dateFromYear:(NSString *)year month:(NSString *)month day:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute;
    - (NSDate *)dateFromIntegersYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
    - (NSDate *)dateWithMidnightTimeFromDate:(NSDate *)date;
    - (NSDate *)monthFirstDayDate:(NSDate *)date;
    - (NSDate *)monthLastDayDate:(NSDate *)date;
    - (NSDate *)dateFromDate:(NSDate *)date byAddingNumberOfDays:(NSInteger)dayNum;
    - (NSDate *)dateWithoutTime:(NSDate *)date;
    
    + (BOOL)date:(NSDate *)date1 isLaterThanOrEqualTo:(NSDate *)date2;
    + (BOOL)date:(NSDate *)date1 isEarlierThanOrEqualTo:(NSDate*)date2;
    + (BOOL)date:(NSDate *)date1 isLaterThan:(NSDate*)date2;
    + (BOOL)date:(NSDate *)date1 isEarlierThan:(NSDate*)date2;
    + (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
    + (BOOL)isSameMonthWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
    
    - (void)calculateSiblingMonthsForDate:(NSDate *)date siblingLength:(NSInteger)months earlierDate:(NSDate **)earlierDate laterDate:(NSDate **)laterDate;*/
    
    
}

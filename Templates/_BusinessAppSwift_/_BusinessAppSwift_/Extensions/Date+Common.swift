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
        
        if (language.isEqual(kLanguageEnglish)) {
            
            newLocale = kLocaleEnglish
            
        } else if (language.isEqual(kLanguageGerman)) {
            
            newLocale = kLocaleGerman
            
        } else {
            
            newLocale = kLocaleEnglish
        }
        
        _dateFormatterForViewingDates?.locale = Locale.init(identifier:newLocale!)
    }
    
    
}

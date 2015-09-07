//
//  GMLoggingConfig.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 04/09/15.
//  Copyright © 2015 Gytenis Mikulėnas 
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

#import "GMLoggingConfig.h"

#ifdef DEBUG

#import "GMCustomLogger.h"

// Default level until app config is received
NSInteger ddLogLevel = DDLogLevelVerbose;

#else

// Default level until app config is received
NSInteger ddLogLevel = DDLogLevelVerbose;

#endif

@implementation GMLoggingConfig

#pragma mark - Public -

+ (void)initializeLoggers {
    
#if TARGET_IPHONE_SIMULATOR
    // Sends log statements to Xcode console - if available
    setenv("XcodeColors", "YES", 1);
#endif
    
    // Add device logging
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
#ifdef DEBUG
    
    // Add Xcode console logging
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[GMCustomLogger sharedInstance]];
    
    // Enable Colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor orangeColor] backgroundColor:nil forFlag:DDLogFlagWarning];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor magentaColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
#endif
}

+ (LogLevelType)logLevel {
    
    return ddLogLevel;
}

+ (void)updateLogLevel:(LogLevelType)logLevel {
    
    ddLogLevel = [self convertedLogLevel:logLevel];
    
    DDLogInfo(@"LogLevel set to %ld", (long)ddLogLevel);
}

#pragma mark - Private -

+ (DDLogLevel)convertedLogLevel:(LogLevelType)logLevel {
    
    DDLogLevel convertedLogLevel = DDLogLevelOff;
    
    switch (logLevel) {
            
        case kLogLevelError:
            
            convertedLogLevel = DDLogLevelError;
            break;
            
        case kLogLevelWarning:
            
            convertedLogLevel = DDLogLevelWarning;
            break;
            
        case kLogLevelInfo:
            
            convertedLogLevel = DDLogLevelInfo;
            break;
            
        case kLogLevelDebug:
            
            convertedLogLevel = DDLogLevelDebug;
            break;
            
        case kLogLevelVerbose:
            
            convertedLogLevel = DDLogLevelVerbose;
            break;
            
        case kLogLevelAll:
            
            convertedLogLevel = DDLogLevelAll;
            break;
            
        default:
            
            convertedLogLevel = DDLogLevelOff;
            break;
    }
    
    return convertedLogLevel;
}

@end

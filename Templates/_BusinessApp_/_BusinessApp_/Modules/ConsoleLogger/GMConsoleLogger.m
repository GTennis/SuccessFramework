//
//  GMConsoleLogger.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "GMConsoleLogger.h"

// For supressing "PerformSelector may cause a leak because its selector is unknown"
// See: http://stackoverflow.com/questions/7017281/performselector-may-cause-a-leak-because-its-selector-is-unknown
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation GMConsoleLogger

@synthesize log = _log;
@synthesize delegate = _delegate;

void customLogger(NSString *format, ...) {
    
    va_list argumentList;
    va_start(argumentList, format);
    
    // Originally NSLog is a wrapper around NSLogv:
    NSLogv(format, argumentList);
    
    // Prepare log message
    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:argumentList];
    NSString *logLine = [[NSString alloc] initWithFormat:@"%@\n", logMessage];
    
    // Add message
    GMConsoleLogger *logger = [GMConsoleLogger sharedInstance];
    [logger.log appendString:logLine];
    
    // Check whether there is something to notify:
    if (logger.delegate) {
        
        SEL selector = @selector(logger:didReceiveLogMessage:);
        if ([logger.delegate respondsToSelector:selector]) {
            
            SuppressPerformSelectorLeakWarning(
                                               [logger.delegate performSelector:selector withObject:logger withObject:logMessage];
                                               );
        }
    }
    
    va_end(argumentList);
}

#pragma mark - Singleton

static GMConsoleLogger *_sharedInstance = nil;

- (id)init {
    
    self = [super init];
    if (self) {
        
        _log = [[NSMutableString alloc] init];
    }
    return self;
}

// Get the shared instance of data source factory
+ (GMConsoleLogger *)sharedInstance {
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[GMConsoleLogger alloc] init];
    }
    
    return _sharedInstance;
}

- (void)clearLog {
    
    _log = [[NSMutableString alloc] init];
    [_log setString:@""];
}

- (DeviceInfo *)deviceInfo {
    
    UIDevice *aDevice = [UIDevice currentDevice];
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    DeviceInfo *deviceInfo = [[DeviceInfo alloc] init];
    // Deprecated need to gen and store in keychain if need to uniquelly identify
    //[passingArray addObject: [aDevice uniqueIdentifier]];
    deviceInfo.name = [aDevice name];
    deviceInfo.localizedModel = [aDevice localizedModel];
    deviceInfo.systemName = [aDevice systemName];
    deviceInfo.systemVersion = [aDevice systemVersion];
    deviceInfo.locale = [defs objectForKey:@"AppleLocale"];
    NSString *timeZoneString = [timeZone localizedName:NSTimeZoneNameStyleShortStandard locale:currentLocale];
    if([timeZone isDaylightSavingTimeForDate:[NSDate date]]){
        timeZoneString = [timeZone localizedName:NSTimeZoneNameStyleShortDaylightSaving locale:currentLocale];
    }
    deviceInfo.timeZone = timeZoneString;
    
    return deviceInfo;
}

@end

#pragma mark - DeviceInfo class

@implementation DeviceInfo

@end

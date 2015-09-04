//
//  GMCustomLogger.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 03/09/15.
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

#import "GMCustomLogger.h"

// For supressing "PerformSelector may cause a leak because its selector is unknown"
// See: http://stackoverflow.com/questions/7017281/performselector-may-cause-a-leak-because-its-selector-is-unknown
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

// Singleton

static GMCustomLogger *_sharedInstance = nil;

@implementation GMCustomLogger

#pragma mark - DDLogger -

- (void)logMessage:(DDLogMessage *)logMessage {
    
    NSString *logMsg = logMessage.message;
    
    if (_logFormatter) {
        
        logMsg = [_logFormatter formatLogMessage:logMessage];
    }
    
    if (logMsg && // check if log is not empty
        logMsg.length > 0) { // check if log contains message string
        
        // Prepare log message
        NSString *logString = [logMsg stringByAppendingString:@"\n"];
        [_log appendString:logString];

        // Notify app debug console
        // Check whether there is something to notify:
        if (_delegate) {
            
            SEL selector = @selector(didReceiveLogMessage:);
            if ([_delegate respondsToSelector:selector]) {
                
                SuppressPerformSelectorLeakWarning(
                                                   [_delegate performSelector:selector withObject:logString];
                                                   );
            }
        }
        
        // Add log to google analytics
#warning add GA logging 
        
    }
}

#pragma mark - Public -

- (id)init {
    
    self = [super init];
    if (self) {
        
        _log = [[NSMutableString alloc] init];
    }
    return self;
}

// Get the shared instance of data source factory
+ (GMCustomLogger *)sharedInstance {
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[GMCustomLogger alloc] init];
    }
    
    return _sharedInstance;
}

- (void)clearLog {
    
    _log = [[NSMutableString alloc] init];
    [_log setString:@""];
}

@end

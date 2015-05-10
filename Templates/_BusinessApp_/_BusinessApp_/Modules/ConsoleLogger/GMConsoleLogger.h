//
//  GMConsoleLogger.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

// Device info object

@interface DeviceInfo : NSObject

//@property (nonatomic, strong) NSString *uniqueIdentifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *localizedModel;
@property (nonatomic, strong) NSString *systemName;
@property (nonatomic, strong) NSString *systemVersion;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *timeZone;

@end

@class GMConsoleLogger;

// Represents interface for logger observers
@protocol GMConsoleLoggerDelegate <NSObject>

- (void)logger:(GMConsoleLogger *)logger didReceiveLogMessage:(NSString *)logMessage;

@end

// Represents custom logger which grabs all NSLog traffic
@interface GMConsoleLogger : NSObject

@property (nonatomic, readonly) NSMutableString *log;
@property (nonatomic, assign) id<GMConsoleLoggerDelegate> delegate;

// Singleton:
+ (GMConsoleLogger *)sharedInstance;

// Clear log
- (void)clearLog;

- (DeviceInfo *)deviceInfo;

// NSLog hook:
void customLogger(NSString *format, ...);

@end
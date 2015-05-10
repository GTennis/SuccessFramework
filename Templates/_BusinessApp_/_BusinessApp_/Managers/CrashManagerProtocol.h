//
//  CrashManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/14/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@protocol CrashManagerProtocol <NSObject>

@property (nonatomic) NSInteger maxAllowedStoredActionsCount;

- (void)logScreenAction:(NSString *)actionString;
- (void)logCustomAction:(NSString *)actionString;
- (void)setUserHasLoggedIn:(BOOL)isLoggedIn;
- (void)setUserLanguage:(NSString *)language;
- (void)crash;
- (NSString *)apiKey;

@end
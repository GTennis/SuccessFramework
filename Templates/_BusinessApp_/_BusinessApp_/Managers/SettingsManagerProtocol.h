//
//  SettingsManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@protocol SettingsManagerProtocol

// First time app launch

- (BOOL)isFirstTimeAppLaunch;
- (void)setIsFirstTimeAppLaunch:(BOOL)isFirstTimeLaunch;

// Languages

- (NSString *)language;
- (NSString *)languageFullName;

- (void)setLanguageEnglish;
- (void)setLanguageGerman;

// Should not be used directly in order to avoid hardcoding @"en", @"de" strings inside other parts
//- (void)setLanguage:(NSString *)language;

@end
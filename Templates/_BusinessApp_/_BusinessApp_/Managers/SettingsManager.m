//
//  SettingsManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "SettingsManager.h"

// Settings group key
#define kSettingsGroupKey @"Settings"

// First time app launch
#define kSettingsFirstTimeAppLaunch @"FirstTimeAppLaunch"

@implementation SettingsManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [NSDate setLocaleForLanguage:self.language];
    }
    
    return self;
}

#pragma mark - Generic

// Generic setter
- (void)setValue:(id)value forKey:(NSString *)valueKey {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *oldDic = [userDefaults objectForKey:kSettingsGroupKey];
    NSMutableDictionary *newDic = nil;
    
    // Create setting value if not exists
    if (!oldDic){
        
        newDic = [[NSMutableDictionary alloc] init];
        
    } else {
        
        newDic = [NSMutableDictionary dictionaryWithDictionary:oldDic];
    }
    
    if (value) {
        
        [newDic setObject:value forKey:valueKey];
        
    } else {
        
        [newDic removeObjectForKey:valueKey];
    }
    
    [userDefaults setObject:newDic forKey:kSettingsGroupKey];
    [userDefaults synchronize];
}

// Generic getter
- (id)valueForKey:(NSString *)valueKey defaultValueIfNotExists:(id)defaultValue {
    
    id result = nil;
    BOOL needsToSynchronize = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [userDefaults objectForKey:kSettingsGroupKey];
    dic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    // Create setting value if not exists
    if (!dic)
    {
        dic = [NSMutableDictionary dictionaryWithCapacity:1];
        needsToSynchronize = YES;
    }
    
    result = [dic objectForKey:valueKey];
    
    if (!result && defaultValue) {
        
        result = defaultValue;
        [dic setObject:result forKey:valueKey];
        needsToSynchronize = YES;
    }
    
    if (needsToSynchronize) {
        
        [userDefaults setObject:dic forKey:kSettingsGroupKey];
        [userDefaults synchronize];
    }
    
    return result;
}

- (void)removeValueForKey:(NSString *) valueKey {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[userDefaults objectForKey:kSettingsGroupKey] mutableCopy];
    [dic removeObjectForKey:valueKey];
    [userDefaults setObject:dic forKey:kSettingsGroupKey];
    [userDefaults synchronize];
}

#pragma mark - First time app launch

- (BOOL)isFirstTimeAppLaunch {
    
    NSNumber *isFirstTimeLaunchNumber = (NSNumber *)[self valueForKey:kSettingsFirstTimeAppLaunch defaultValueIfNotExists:nil];
    
    // If it's the first launch then there will be no such settings saved in preferences OR it might be resetted from code later (so value is set to YES)
    if (!isFirstTimeLaunchNumber || [isFirstTimeLaunchNumber boolValue] == YES) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

- (void)setIsFirstTimeAppLaunch:(BOOL)isFirstTimeLaunch {
    
    [super setValue:[NSNumber numberWithBool:isFirstTimeLaunch] forKey:kSettingsFirstTimeAppLaunch];
}

#pragma mark - Languages

- (NSString *)language {
    
    return LocalizationGetLanguage;
}

- (NSString *)languageFullName {
    
    return LocalizationGetCurrentLanguageFullName;
}

- (void)setLanguage:(NSString *)language {
    
    LocalizationSetLanguage(language);
    [NSDate setLocaleForLanguage:language];
}

- (void)setLanguageEnglish {
    
    [self setLanguage:kLanguageEnglish];
}

- (void)setLanguageGerman {
    
    [self setLanguage:kLanguageGerman];
}

/*
#pragma mark - Notifications

- (NSString *)remoteNotificationsDeviceToken {
    
    // TODO:
    // ...
}

- (void)setRemoteNotificationsDeviceToken:(NSString *)remoteNotificationsDeviceToken {
    
    // TODO:
    // ...
 
}*/

@end

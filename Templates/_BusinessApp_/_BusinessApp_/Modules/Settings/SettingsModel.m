//
//  SettingsModel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "SettingsModel.h"

@implementation SettingsModel

- (void)setLanguageEnglish {
    
    [self.settingsManager setLanguageEnglish];
}

- (void)setLanguageGerman {
    
    [self.settingsManager setLanguageGerman];
}

@end

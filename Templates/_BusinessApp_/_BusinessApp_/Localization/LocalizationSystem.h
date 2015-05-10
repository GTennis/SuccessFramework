//
//  LocalizationSystem.h
//
//  Created by Juan Albero Sanchis on 27/02/10.
//  Modified by Gytenis Mikulėnas on 6/14/13
//
//  Copyright Aggressive Mediocrity 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNOTIFICATION_LOCALIZATION_HAS_CHANGED @"NotificationLocalizationHasChanged"

// Shortcut method of main method
#define GMLocalizedString(key) \
[[LocalizationSystem sharedLocalSystem] localizedStringForKey:(key) value:nil]

// Main method to be used to localize string
#define GMLocalizedStringWithComment(key, comment) \
[[LocalizationSystem sharedLocalSystem] localizedStringForKey:(key) value:(comment)]

// Change current app language - (after it notification will be posted: NOTIFICATION_LOCALIZATION_HAS_CHANGED)
#define LocalizationSetLanguage(language) \
[[LocalizationSystem sharedLocalSystem] setLanguage:(language)]

// Get short name of current language: 'en', 'de'
#define LocalizationGetLanguage \
[[LocalizationSystem sharedLocalSystem] getLanguage]

// Get long name of current language: 'English', 'Deutsch'
#define LocalizationGetCurrentLanguageFullName \
[[LocalizationSystem sharedLocalSystem] getFullLanguageNameForKey:[[LocalizationSystem sharedLocalSystem] getLanguage]]

// returns ACLanguage (ACLanguage will contain both short and long name)
#define LocalizationGetCurrentACLanguage \
[[LocalizationSystem sharedLocalSystem] getCurrentTSLanguage]

// get long language name for short name, e.g. 'English' for 'en'
#define LocalizationGetLanguageFullName(languageKey) \
[[LocalizationSystem sharedLocalSystem] getFullLanguageNameForKey:(languageKey)]

// Reset to use OS default language
#define LocalizationReset \
[[LocalizationSystem sharedLocalSystem] resetLocalization]

@class ACLanguage; // class is used to get short and long language name (e.g.: en, English)


// LocalizationSystem is used to enable language change in app during runtime without
// having to restart application. 
//
// MAIN METHODS:
// 1. Instead of using NSLocalizedString(key, comment), must use: GMLocalizedString(key, comment)
// 2. To change language, use: LocalizationSetLanguage(language) // language is short name
// 
// WARNING:
// 1. If ViewController was loaded before language change, it must catch notification (NOTIFICATION_LOCALIZATION_HAS_CHANGED)
// and implement method to update it's localizible strings.
// 2. Strings set by system are not changed, e.g. navigation controller back button, cancel button in search bar, UISwitch on/off strings, etc.
// These change only after application was restarted (killed and launched again)
//
// 2.1. To change value for naviation controller back button can use this method:
//
//- (void)setBackBarButtonTitleForNavigationBar
//{
//    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: GMLocalizedString(@"NavigationItemBackButton", nil) style: UIBarButtonItemStyleBordered target: nil action: nil];
//    self.navigationController.topViewController.navigationItem.backBarButtonItem = newBackButton;
//    [newBackButton release];        
//}

@interface LocalizationSystem : NSObject 
{
	NSString *language;
}

// you really shouldn't care about this functions and use the MACROS
+ (LocalizationSystem *)sharedLocalSystem;

// gets the string localized
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

//sets the language
- (void) setLanguage:(NSString*) language;

//gets the current language
- (NSString*) getLanguage;
- (ACLanguage*) getCurrentACLanguage;

//resets this system.
- (void) resetLocalization;

- (NSString*)getFullLanguageNameForKey:(NSString*)key;

@end

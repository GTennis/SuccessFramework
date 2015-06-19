//
//  LocalizationSystem.m
//
//  Created by Juan Albero Sanchis on 27/02/10.
//  Modified by Gytenis Mikulėnas on 6/14/13
//
//  Copyright Aggressive Mediocrity 2010. All rights reserved.
//

#import "LocalizationSystem.h"
#import "LanguageObject.h"

@implementation LocalizationSystem

//Singleton instance
static LocalizationSystem *_sharedLocalSystem = nil;

//Current application bungle to get the languages.
static NSBundle *bundle = nil;

+ (LocalizationSystem *)sharedLocalSystem
{
	@synchronized([LocalizationSystem class])
	{
		if (!_sharedLocalSystem){
			_sharedLocalSystem = [[self alloc] init];
		}
		return _sharedLocalSystem;
	}
	return nil;
}

+(id)alloc
{
	@synchronized([LocalizationSystem class])
	{
		NSAssert(_sharedLocalSystem == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedLocalSystem = [super alloc];
		return _sharedLocalSystem;
	}
	// to avoid compiler warning
	return nil;
}

- (id)init
{
    if ((self = [super init])) 
    {
		//empty.
		bundle = [NSBundle mainBundle];
	}
    return self;
}

// Gets the current localized string as in AMLocalizedString.
//
// example calls:
// AMLocalizedString(@"Text to localize",@"Alternative text, in case hte other is not find");
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
	//return [bundle localizedStringForKey:key value:comment table:nil];
    return [bundle localizedStringForKey:key value:nil table:nil];
}

// Sets the desired language of the ones you have.
// 
// If this function is not called it will use the default OS language.
// If the language does not exists y returns the default OS language.
- (void) setLanguage:(NSString*) l
{
    DLog(@"[%@] setLanguage to %@", NSStringFromClass([self class]), l);
	
	NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
	
	if (path == nil) {
		//in case the language does not exists
		[self resetLocalization];
    }
	else {
		bundle = [NSBundle bundleWithPath:path];   
    }
    
    [[NSUserDefaults standardUserDefaults] setObject: [NSArray arrayWithObjects:l, nil] forKey:@"AppleLanguages"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_LOCALIZATION_HAS_CHANGED object:nil];
}

// Just gets the current setted up language.
- (NSString*) getLanguage
{
	NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];

	NSString *preferredLang = [languages objectAtIndex:0];

    // Only 2-letter language codes are used accross the app. This method will always return first to letters on country code (e.g. for en-GB it will return en)
    NSString *code = [preferredLang substringWithRange:NSMakeRange(0, 2)];
    
    return code;
}

- (LanguageObject*) getCurrentACLanguage
{
    NSString* shortName = [self getLanguage];
    NSString* longName = [self getFullLanguageNameForKey:shortName];
    
    LanguageObject *lang = [[LanguageObject alloc] initWithShortName:shortName withLongName:longName];
    
    return lang;
}

// Resets the localization system, so it uses the OS default language.
//
- (void) resetLocalization
{
	bundle = [NSBundle mainBundle];
}


- (NSString*)getFullLanguageNameForKey:(NSString*)key
{
    // returns full language name in that language e.g.:
    // en = English
    // de = Deutsch
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:key];
    return [locale displayNameForKey:NSLocaleIdentifier value:key];
}

@end

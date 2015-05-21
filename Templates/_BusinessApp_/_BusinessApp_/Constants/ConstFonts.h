//
//  ConstFonts.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

// Font types are setted in IB as user defined runtime attributes and supported by FontType categories

// Store custom fonts in Resources/Fonts folder. For each font add an entry (filename.extension) under UIAppFonts (Fonts provided by application) inside plist

#define kFontBoldType   @"FontBold"
#define kFontBold   @"Glockenspiel"

#define kFontNormalType @"FontNormal"
#define kFontNormal @"Glockenspiel"

// Aliases for fontWithName: method
#define kFontBoldWithSize(__SIZE__) [UIFont fontWithName:kFontBold size:__SIZE__]
#define kFontNormalWithSize(__SIZE__) [UIFont fontWithName:kFontNormal size:__SIZE__]

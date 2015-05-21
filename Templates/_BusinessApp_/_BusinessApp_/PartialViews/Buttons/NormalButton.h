//
//  NormalButton.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseButton.h"
#import "ConstColors.h"
#import "ConstFonts.h"

// Border
#define kButtonBorderSize 1.0f
#define kButtonBorderColor kColorGrayDark

// Corner
#define kButtonCornerRadius 3.0f

// Normal state style
#define kButtonBackgroundColorNormalState kColorGreen
#define kButtonTextColorNormalState kColorWhite

// Highlighted state style
#define kButtonBackgroundColorHighlightedState kColorGreen
#define kButtonTextColorHighlightedState kColorWhite

// Disabled state style
#define kButtonBackgroundColorDisabledState kColorGrayLight1
#define kButtonTextColorDisabledState kColorWhite

// Font
#define kButtonTextFont kFontNormal
#define kButtonTextFontSize 15

@interface NormalButton : BaseButton

@end

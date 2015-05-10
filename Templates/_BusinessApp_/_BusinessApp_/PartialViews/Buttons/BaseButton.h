//
//  BaseButton.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstColors.h"
#import "ConstFonts.h"

// Border
#define kButtonBorderSize 1.0f
#define kButtonBorderColor kColorWhite

// Corner
#define kButtonCornerRadius 3.0f

// Normal state style
#define kButtonBackgroundColorNormalState kColorGrayDark
#define kButtonTextColorNormalState kColorWhite

// Highlighted state style
#define kButtonBackgroundColorHighlightedState kColorBlack
#define kButtonTextColorHighlightedState kColorWhite

// Disabled state style
#define kButtonBackgroundColorDisabledState kColorGrayLight1
#define kButtonTextColorDisabledState kColorWhite

// Font
#define kButtonTextFont kFontNormal
#define kButtonTextFontSize 15

@interface BaseButton : UIButton

// Borders
@property (nonatomic) CGFloat borderSize;
@property (nonatomic, strong) UIColor *borderColor;

// Corners
@property (nonatomic) CGFloat cornerRadius;

// Normal state
@property (nonatomic, strong) UIColor *backgroundNormalColor;
@property (nonatomic, strong) UIColor *textNormalColor;

// Highlighted state
@property (nonatomic, strong) UIColor *backgroundHighlightedColor;
@property (nonatomic, strong) UIColor *textHighlightedColor;

// Disabled state
@property (nonatomic, strong) UIColor *backgroundDisabledColor;
@property (nonatomic, strong) UIColor *textDisabledColor;

// Font
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic) CGFloat fontSize;

- (void)initializeProperties;

@end

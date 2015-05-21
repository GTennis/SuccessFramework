//
//  BaseButton.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

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

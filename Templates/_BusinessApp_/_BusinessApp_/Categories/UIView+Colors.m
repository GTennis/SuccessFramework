//
//  UIView+Colors.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "UIView+Colors.h"

@implementation UIView (Colors)

- (NSString *)colorNameForColor:(UIColor *)color {
    
    NSString *backgroundColorName = @"Unknown";
    
    if ([self color:color isEqualToColor:kColorGrayLight]) {
        
        backgroundColorName = kColorGrayLightName;
        
    } else if ([self color:color isEqualToColor:kColorGrayDark]) {
        
        backgroundColorName = kColorGrayDarkName;
        
    } else if ([self color:color isEqualToColor:kColorRedLight]) {
        
        backgroundColorName = kColorRedLightName;
        
    } else if ([self color:color isEqualToColor:kColorRed]) {
        
        backgroundColorName = kColorRedName;
        
    } else if ([self color:color isEqualToColor:kColorRedDark]) {
    
        backgroundColorName = kColorRedDarkName;
        
    } else if ([self color:color isEqualToColor:kColorGray]) {
        
        backgroundColorName = kColorGrayName;
        
    } else if ([self color:color isEqualToColor:kColorGrayLight1]) {
        
        backgroundColorName = kColorGrayLightName1;
        
    } else if ([self color:color isEqualToColor:kColorGrayLight2]) {
        
        backgroundColorName = kColorGrayLightName2;
        
    } else if ([self color:color isEqualToColor:kColorBlue]) {
        
        backgroundColorName = kColorBlueName;
        
    } else if ([self color:color isEqualToColor:kColorWhite]) {
        
        backgroundColorName = kColorWhiteName;
        
    } else if ([self color:color isEqualToColor:kColorBlack]) {
        
        backgroundColorName = kColorBlackName;

    } else if ([self color:color isEqualToColor:kColorGold]) {

        backgroundColorName = kColorGoldName;

    } else if ([self color:color isEqualToColor:kColorGreen]) {

        backgroundColorName = kColorGreenName;
    }
    
    return backgroundColorName;
}

- (UIColor *)colorForColorName:(NSString *)colorName {
    
    UIColor *color = nil;
    
    if ([colorName isEqualToString:kColorGrayLightName]) {
        
        color = kColorGrayLight;
        
    } else if ([colorName isEqualToString:kColorGrayDarkName]) {
        
        color = kColorGrayDark;
        
    } else if ([colorName isEqualToString:kColorRedLightName]) {
        
        color = kColorRedLight;
        
    } else if ([colorName isEqualToString:kColorRedName]) {
        
        color = kColorRed;
        
    } else if ([colorName isEqualToString:kColorRedDarkName]) {
        
        color = kColorRedDark;
        
    } else if ([colorName isEqualToString:kColorGrayName]) {
        
        color = kColorGray;
        
    } else if ([colorName isEqualToString:kColorGrayLightName1]) {
        
        color = kColorGrayLight1;
        
    } else if ([colorName isEqualToString:kColorGrayLightName2]) {
        
        color = kColorGrayLight2;

    } else if ([colorName isEqualToString:kColorBlueName]) {
        
        color = kColorBlue;
        
    } else if ([colorName isEqualToString:kColorWhiteName]) {
        
        color = kColorWhite;
        
    } else if ([colorName isEqualToString:kColorBlackName]) {
        
        color = kColorBlack;

    } else if ([colorName isEqualToString:kColorGoldName]) {

        color = kColorGold;

    } else if ([colorName isEqualToString:kColorGreenName]) {

        color = kColorGreen;
    }
    
    return color;
}

// Used from: http://stackoverflow.com/questions/970475/how-to-compare-uicolors
- (BOOL)color:(UIColor *)color isEqualToColor:(UIColor *)otherColor {
    
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            return [UIColor colorWithCGColor:CGColorCreate(colorSpaceRGB, components)];
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(color);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:otherColor];
}

#pragma mark - Background colors

- (NSString *)backgroundColorName {
    
    NSString *backgroundColorName = [self colorNameForColor:self.backgroundColor];
    
    return backgroundColorName;
}

- (void)setBackgroundColorName:(NSString *)backgroundColorName {
    
    self.backgroundColor = [self colorForColorName:backgroundColorName];
}

#pragma mark - Label text colors

- (NSString *)labelTitleColorName {
    
    UILabel *label = (UILabel *)self;
    NSString *labelTextColorName = [self colorNameForColor:label.textColor];
    
    return labelTextColorName;
}

- (void)setLabelTitleColorName:(NSString *)labelTitleColorName {
    
    UILabel *label = (UILabel *)self;
    label.textColor = [self colorForColorName:labelTitleColorName];
}

#pragma mark - Button text colors

- (NSString *)buttonTitleColorName {
    
    UIButton *button = (UIButton *)self;
    NSString *buttonTitleColorName = [self colorNameForColor: [button titleColorForState:UIControlStateNormal]];
    
    return buttonTitleColorName;
}

- (void)setButtonTitleColorName:(NSString *)buttonTitleColorName {
    
    UIButton *button = (UIButton *)self;
    [button setTitleColor:[self colorForColorName:buttonTitleColorName] forState:UIControlStateNormal];
}

@end

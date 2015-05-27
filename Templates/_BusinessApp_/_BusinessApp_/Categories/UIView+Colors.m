//
//  UIView+Colors.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
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

    } else if ([self color:color isEqualToColor:kColorYellow]) {

        backgroundColorName = kColorYellowName;

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

    } else if ([colorName isEqualToString:kColorYellowName]) {

        color = kColorYellow;

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

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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

//
//  BaseButton.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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

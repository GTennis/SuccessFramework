//
//  BaseTextField.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
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

#import "DataInputFormTextFieldProtocol.h"
#import "JVFloatLabeledTextField.h"
#import "ConstColors.h"
#import "ConstFonts.h"

@interface BaseTextField : JVFloatLabeledTextField <DataInputFormTextFieldProtocol>

#pragma mark - Public -

@property (nonatomic) TextFieldPosition position;
@property (nonatomic) TextFieldStateType fieldState;

#pragma mark - Protected -

- (void)customize;
- (void)addBottomSeparatorLine;

@property (readonly) UIEdgeInsets insidePadding; // inside background color full rectangle
@property (readonly) UIEdgeInsets outsidePadding; // outside background color full rectangle

@property (nonatomic) BOOL separatorsAlreadyAdded;
@property (nonatomic) BOOL hasTopSeparatorLine;
@property (nonatomic) BOOL hasMiddleSeparatorLine;
@property (nonatomic) BOOL hasBottomSeparatorLine;

// Border
@property (readonly) CGFloat borderCornerRadius;
@property (readonly) CGFloat borderWidth;
@property (readonly) UIColor *borderColor;

// Text
@property (readonly) UIColor *textBackgroundColor;
@property (readonly) UIColor *textColor_;
@property (readonly) NSString *textFont;
@property (readonly) CGFloat textSize;

// Text offsets
@property (readonly) CGPoint textOffset;
@property (readonly) UIColor *textCursorColor;
@property (readonly) CGPoint textOffsetWhileEditing;
@property (readonly) CGSize textClearButtonSizeWhileEditing;

// Placeholder
@property (readonly) UIColor *placeholderBackgroundColor;
@property (readonly) UIColor *placeholderTextColor;
@property (readonly) UIColor *placeholderTextColorWhileEditing;
@property (readonly) NSString *placeholderTextFont;
@property (readonly) CGFloat placeholderTextSize;
@property (readonly) CGFloat placeholderTextOffsetY;

// Separator line
@property (readonly) CGFloat separatorLineOffsetY;

@end

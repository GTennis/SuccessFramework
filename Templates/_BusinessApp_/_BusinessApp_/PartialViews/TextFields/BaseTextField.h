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

// Corners
#define kTextFieldBorderCornerRadius 0.0f // 4.0f

// Border
#define kTextFieldBorderWidth 0.0f //1.0f
#define kTextFieldBorderColor [kColorGrayLight1 CGColor]

// Text
#define kTextFieldTextColor kColorGrayDark
#define kTextFieldTextFont kFontNormal
#define kTextFieldTextSize 15.0f

// Text offsets
#define kTextFieldDefaultOffset CGPointMake(12.0f, 5.0f)
#define kTextFieldDefaultEditingOffset CGPointMake(12.0f, 5.0f)
#define kTextFieldDefaultEditingMargins 32.0f

// Placeholder
#define kTextFieldPlaceholderBackgroundColor [UIColor clearColor]
#define kTextFieldFloatingPlaceholderColorWhileEditing kColorGreen
#define kTextFieldFloatingPlaceholderColor kColorGreen
#define kTextFieldPlaceholderColor kColorGreen
#define kTextFieldCursorColor kColorGrayDark

// Floating label
#define kTextFieldFloatingLabelFont kFontNormalWithSize(12)
#define kTextFieldFloatingLabelPaddingY 5.0f

// Separator line left offset
#define kTextFieldSeparatorLeftOffset 12.0f

@interface BaseTextField : JVFloatLabeledTextField <DataInputFormTextFieldProtocol>

#pragma mark - Public -

@property (nonatomic) TextFieldPosition position;
@property (nonatomic) TextFieldStateType fieldState;

#pragma mark - Protected -

- (void)commonInit;

@end

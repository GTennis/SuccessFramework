//
//  BaseTextField.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseTextFieldProtocol.h"
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
#define kTextFieldFloatingPlaceholderColorWhileEditing kColorBlue
#define kTextFieldFloatingPlaceholderColor kColorBlue
#define kTextFieldPlaceholderColor kColorBlue
#define kTextFieldCursorColor kColorGrayDark

// Separator line left offset
#define kTextFieldSeparatorLeftOffset 12.0f

@interface BaseTextField : JVFloatLabeledTextField <BaseTextFieldProtocol>

@property (nonatomic) TextFieldPosition position;
@property (nonatomic) TextFieldStateType fieldState;

// Protected
- (void)customize;

@end

//
//  BaseTextFieldProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

typedef NS_ENUM(NSInteger, TextFieldStateType) {
    
    AucTextFieldStateNormal,
    AucTextFieldStateValueMissing
};

typedef NS_ENUM(NSInteger, TextFieldPosition) {
    
    kTextFieldPositionIsSingle,
    kTextFieldPositionIsFirst,
    kTextFieldPositionIsMiddle,
    kTextFieldPositionIsLast
};

@protocol BaseTextFieldProtocol <NSObject>

@property (nonatomic) BOOL isRequired;

- (void)setFieldState:(TextFieldStateType)fieldState;
- (void)validateValue;
- (void)resetValidatedValues;

@end

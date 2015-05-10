//
//  KeyboardControlProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/5/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@protocol KeyboardControlProtocol

@property (nonatomic, strong) UIView *activeField;
@property (nonatomic, strong) NSArray *fields;

- (id)initWithFields:(NSArray *)fields actionTitle:(NSString *)actionTitle;

@end
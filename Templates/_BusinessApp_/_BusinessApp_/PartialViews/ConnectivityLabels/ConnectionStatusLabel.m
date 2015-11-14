//
//  ConnectionStatusLabel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
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

#import "ConnectionStatusLabel.h"
#import "PhoneCallCommand.h"

@interface ConnectionStatusLabel () {
    
    PhoneCallCommand *_phoneCallCommand;
}

@end

@implementation ConnectionStatusLabel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    // Add corner radius if defined
    if (kConnectionStatusLabelBorderCornerRadius) {
        
        self.layer.cornerRadius = kConnectionStatusLabelBorderCornerRadius;
        self.layer.masksToBounds = YES;
    }
    
    // Add border if defined
    if (kTextFieldBorderWidth) {
        
        self.layer.borderColor = kConnectionStatusLabelBorderColor;
        self.layer.borderWidth = kConnectionStatusLabelBorderWidth;
    }
    
    self.backgroundColor = kConnectionStatusLabelBackgroundColor;
    
    self.titleLabel.textColor = kConnectionStatusLabelTextColor;
    self.titleLabel.font = [UIFont fontWithName:kConnectionStatusLabelTextFont size:kConnectionStatusLabelTextSize];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    
    [self setTitle:GMLocalizedString(kConnnectionStatusLabelMessageKey) forState:UIControlStateNormal];
    
    self.tag = kConnectionStatusLabelTag;
    
    [self addTarget:self action:@selector(didPressed) forControlEvents:UIControlEventTouchUpInside];
    
    _phoneCallCommand = [[PhoneCallCommand alloc] initWithPhoneNumberString:kConnectionStatusLabelPhoneNumber];
}

#pragma mark - Private -

- (void)didPressed {
    
    NSError *error = nil;
    BOOL canExecute = [_phoneCallCommand canExecute:&error];
    
    if (canExecute) {
        
        [_phoneCallCommand execute];
    }
}

@end

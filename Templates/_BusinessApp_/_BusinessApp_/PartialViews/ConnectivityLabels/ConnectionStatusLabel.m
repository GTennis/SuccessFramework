//
//  ConnectionStatusLabel.m
//  MyInsurrance
//
//  Created by Gytenis Mikulenas on 11/6/15.
//  Copyright © 2015 OKOTTA Germany GmbH. All rights reserved.
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

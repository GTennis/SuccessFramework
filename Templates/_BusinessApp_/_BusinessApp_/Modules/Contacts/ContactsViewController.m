//
//  ContactsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
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

#import "ContactsViewController.h"
#import <MessageUI/MessageUI.h>
#import "GMAlertView.h"
#import "SendEmailCommand.h"
#import "PhoneCallCommand.h"

// Send email settings
#define kContactsViewControllerEmailSubject @"From Success Framework app"
#define kContactsViewControllerEmailMessage @"Hello, I have a question!"
#define kContactsViewControllerRecipients @[@"test@test.com"]

// Phone call settings
#define kContactsViewControllerPhoneNumber @"123456789"

#define kContactsViewControllerOkKey @"Ok"

@interface ContactsViewController () {
    
    SendEmailCommand *_sendEmailCommand;
    PhoneCallCommand *_phoneCallCommand;
}

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
}

#pragma mark - Protected

- (void)commonInit {
    
    [super commonInit];
    
    _sendEmailCommand = [[SendEmailCommand alloc] initWithViewController:self subject:kContactsViewControllerEmailSubject message:kContactsViewControllerEmailMessage recipients:kContactsViewControllerRecipients];
    _phoneCallCommand = [[PhoneCallCommand alloc] initWithPhoneNumberString:kContactsViewControllerPhoneNumber];
}

- (void)prepareUI {
    
    [super prepareUI];
    
    // ...
}

- (void)renderUI {
    
    [self renderUI];
    
    // ...
}

#pragma mark - IBActions

- (IBAction)emailPressed:(UIButton *)sender {
    
    NSError *error = nil;
    BOOL canExecute = [_sendEmailCommand canExecute:&error];
    
    if (canExecute) {
        
        [_sendEmailCommand execute];
        
    } else {
        
        GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:self title:nil message:error.localizedDescription cancelButtonTitle:GMLocalizedString(kContactsViewControllerOkKey) otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)phoneCallPressed:(UIButton *)sender {
    
    NSError *error = nil;
    BOOL canExecute = [_phoneCallCommand canExecute:&error];
    
    if (canExecute) {
        
        [_phoneCallCommand execute];
        
    } else {
        
        GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:self title:nil message:error.localizedDescription cancelButtonTitle:GMLocalizedString(kContactsViewControllerOkKey) otherButtonTitles:nil];
        [alertView show];
    }
}

@end

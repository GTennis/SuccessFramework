//
//  ContactsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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

- (void)commonInit {
    
    [super commonInit];
    
    _sendEmailCommand = [[SendEmailCommand alloc] initWithViewController:self subject:kContactsViewControllerEmailSubject message:kContactsViewControllerEmailMessage recipients:kContactsViewControllerRecipients];
    _phoneCallCommand = [[PhoneCallCommand alloc] initWithPhoneNumberString:kContactsViewControllerPhoneNumber];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - IBActions

- (IBAction)emailButtonPressed:(UIButton *)sender {
    
    NSError *error = nil;
    BOOL canExecute = [_sendEmailCommand canExecute:&error];
    
    if (canExecute) {
        
        [_sendEmailCommand execute];
        
    } else {
        
        GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:self title:nil message:error.localizedDescription cancelButtonTitle:GMLocalizedString(kContactsViewControllerOkKey) otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)phoneCallButtonPressed:(UIButton *)sender {
    
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

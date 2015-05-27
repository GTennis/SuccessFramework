//
//  SendEmailCommand.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 20/05/15.
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

#import "SendEmailCommand.h"
#import <MessageUI/MessageUI.h>

#define kSendEmailCommandNotConfiguredDomain @"kSendEmailCommandNotConfiguredDomain"
#define kSendEmailCommandNotConfiguredAlertTextKey @"kSendEmailCommandNotConfiguredAlertTextKey"

@interface SendEmailCommand () <MFMailComposeViewControllerDelegate> {
    
    UIViewController *_viewContoller;
    MFMailComposeViewController *_mailComposerViewController;

    NSString *_subject;
    NSArray *_recipients;
}

@end

@implementation SendEmailCommand

- (instancetype)initWithViewController:(UIViewController *)viewController subject:(NSString *)subject message:(NSString *)message recipients:(NSArray *)recipients {
    
    self = [super init];
    if (self) {
        
        _viewContoller = viewController;
        _subject = subject;
        _message = message;
        _recipients = recipients;
    }
    
    return self;
}

#pragma mark - CommandProtocol

- (BOOL)canExecute:(NSError **)error {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        return YES;
        
    } else {
        
        NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:GMLocalizedString(kSendEmailCommandNotConfiguredAlertTextKey)};
        *error = [NSError errorWithDomain:kSendEmailCommandNotConfiguredDomain code:0 userInfo:userInfoDict];
        
        return NO;
    }
}

- (void)execute {
    
    NSError *error = nil;
    
    if ([self canExecute:&error]) {
        
        _mailComposerViewController = [[MFMailComposeViewController alloc] init];
        
        // Add subject if passed
        if (_subject.length > 0) {
            
            [_mailComposerViewController setSubject:_subject];
        }
        
        // Add message if passed
        if (_message.length > 0) {
            
            [_mailComposerViewController setMessageBody:_message isHTML:NO];
        }
        
        // Add recipients if passed
        if (_recipients.count > 0) {
            
            [_mailComposerViewController setToRecipients:_recipients];
        }
        
        // Assign delegate
        _mailComposerViewController.mailComposeDelegate = self;
        
        // Show send email
        [_viewContoller presentViewController:_mailComposerViewController animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [_mailComposerViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

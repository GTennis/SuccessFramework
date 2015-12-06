//
//  ConsoleLogViewController.m
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

#import "ConsoleLogViewController.h"
#import "SendEmailCommand.h"
#import "GMCustomLogger.h"

#define kConsoleLogViewControllerDevEmail @"developer@dev.com"
#define kConsoleLogViewControllerCannotSendEmptyLogAlertOkKey @"Ok"
#define kConsoleLogViewControllerCannotSendEmptyLogAlertMessage @"kConsoleLogViewControllerCannotSendEmptyLogAlertMessage"

static ConsoleLogViewController *_sharedInstance = nil;

@interface ConsoleLogViewController () {
    
    NSMutableString *_logString;
    SendEmailCommand *_sendEmailCommand;
}

@end

@implementation ConsoleLogViewController

- (void)commonInit {
    
    [super commonInit];
    
    _sendEmailCommand = [[SendEmailCommand alloc] initWithViewController:self subject:@"AppLogs" message:nil recipients:@[kConsoleLogViewControllerDevEmail] attachments:nil];
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _logString = [[NSMutableString alloc] init];
        [GMCustomLogger sharedInstance].delegate = self;
    }
    return self;
}

- (void)dealloc {
    
    [GMCustomLogger sharedInstance].delegate = nil;
}

// Get the shared instance of data source factory
+ (ConsoleLogViewController *)sharedInstance {
    
    if (!_sharedInstance) {
        
        NSString *viewControllerClassName = @"ConsoleLogViewController";
        
        if (isIpad) {
            
            viewControllerClassName = [NSString stringWithFormat:@"%@_ipad", viewControllerClassName];
            
        } else {
            
            viewControllerClassName = [NSString stringWithFormat:@"%@_iphone", viewControllerClassName];
        }
        
        Class deviceClass = NSClassFromString(viewControllerClassName);
        
        _sharedInstance = [[deviceClass alloc] init];
    }
    
    return _sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView.text = [GMCustomLogger sharedInstance].log;
    _logString = [GMCustomLogger sharedInstance].log;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    _textView.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public -

#pragma mark IBActions

- (IBAction)closePressed:(id)sender {
    
    [self.view removeFromSuperview];
}

- (IBAction)clearLogPressed:(id)sender {
    
    [_logString setString:@""];
    [_textView setText:_logString];
    
    [[GMCustomLogger sharedInstance] clearLog];
}

- (IBAction)reportPressed:(id)sender {
    
    //DeviceInfo *deviceInfo = [[GMConsoleLogger sharedInstance] deviceInfo];
    
    if ([_logString length] > 0) {
        
        _sendEmailCommand.message = _logString;
        NSError *error = nil;
        BOOL canExecute = [_sendEmailCommand canExecute:&error];
        
        if (canExecute) {
            
            [_sendEmailCommand executeWithCallback:nil];
            
        } else {
            
            [self.messageBarManager showMessageWithTitle:@"" description:error.localizedDescription type:MessageBarMessageTypeError duration:kMessageBarManagerMessageDuration];
        }
        
    } else {
        
        [self.messageBarManager showMessageWithTitle:@"" description:GMLocalizedString(kConsoleLogViewControllerCannotSendEmptyLogAlertMessage) type:MessageBarMessageTypeError duration:kMessageBarManagerMessageDuration];
    }
}

#pragma mark - Protected -

- (void)handleNetworkRequestSuccess:(NSNotification *)notification {
    
    //GMAlertView *alert = [[GMAlertView alloc] initWithViewController:self title:nil message:GMLocalizedString(@"Did posted") cancelButtonTitle:GMLocalizedString(@"OK") otherButtonTitles:nil];
    //[alert show];
}

- (void)handleNetworkRequestError:(NSNotification *)notification {
    
    //GMAlertView *alert = [[GMAlertView alloc] initWithViewController:self title:nil message:GMLocalizedString(@"Failed to post") cancelButtonTitle:GMLocalizedString(@"OK") otherButtonTitles:nil];
    //[alert show];
}

#pragma mark ACLoggerObserver

- (void)didReceiveLogMessage:(NSString *)logMessage {
    
    [self performSelectorOnMainThread:@selector(appendLogMessage:) withObject:logMessage waitUntilDone:NO];
}

#pragma mark - Private -

- (void)appendLogMessage:(NSString *)logMessage {
    
    /*
     // Check whether should truncate:
     if (_logText.length + logMessage.length > kLogMaxLength) {
     
     // Truncate:
     NSRange range = {_logText.length - (logMessage.length * 2) - 1, (logMessage.length * 2)};
     [_logText deleteCharactersInRange:range];
     }
     */
    
    // Check whether matches current filter:
    /*BOOL add = YES;
     NSString *filterText = _searchBar.text;
     if (filterText.length > 0) {
     
     NSRange filterMatchRange = [logMessage rangeOfString:filterText];
     if (filterMatchRange.location == NSNotFound) {
     
     add = NO;
     }
     }
     
     // Append:
     if (add) {*/
    
    //NSString *line = [[NSString alloc] initWithFormat:@"%@\n", logMessage];
    //[_logString appendString:line];
    
    // Update text:
    _textView.text = [GMCustomLogger sharedInstance].log;
    
    CGSize newSize = [_textView sizeThatFits:CGSizeMake(_textView.frame.size.width, MAXFLOAT)];
    
    _textViewHeightConstraint.constant = newSize.height;
    
    _scrollView.contentSize = CGSizeMake(newSize.width, newSize.height);
    //}
}

@end

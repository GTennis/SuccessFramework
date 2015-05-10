//
//  ConsoleLogViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ConsoleLogViewController.h"
#import "GMAlertView.h"

@interface ConsoleLogViewController () {
    
    NSMutableString *_logString;
}

@end

@implementation ConsoleLogViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _logString = [[NSMutableString alloc] init];
        [GMConsoleLogger sharedInstance].delegate = self;
    }
    return self;
}

- (void)dealloc {
    
    [GMConsoleLogger sharedInstance].delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView.text = [GMConsoleLogger sharedInstance].log;
    _logString = [GMConsoleLogger sharedInstance].log;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    _textView.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    _textView.text = [GMConsoleLogger sharedInstance].log;
    
    CGSize newSize = [_textView sizeThatFits:CGSizeMake(_textView.frame.size.width, MAXFLOAT)];
    
    _textViewHeightConstraint.constant = newSize.height;
    
    _scrollView.contentSize = CGSizeMake(newSize.width, newSize.height);
    //}
}

#pragma mark - IBActions

- (IBAction)closePressed:(id)sender {
    
    [self.view removeFromSuperview];
}

- (IBAction)clearLogPressed:(id)sender {
    
    [_logString setString:@""];
    [_textView setText:_logString];
    
    [[GMConsoleLogger sharedInstance] clearLog];
}

- (IBAction)reportPressed:(id)sender {
    
    //DeviceInfo *deviceInfo = [[AucConsoleLogger sharedInstance] deviceInfo];
    
    if ([_logString length] > 0) {
        
        // Send log to server
        //[ReportLogWebservice sendLog:_logText withDeviceInfo:deviceInfo delegate:self context:nil];
        
    } else {
        
        GMAlertView *alert = [[GMAlertView alloc] initWithViewController:self title:nil message:GMLocalizedString(@"Log is empty") cancelButtonTitle:GMLocalizedString(@"OK") otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - ACLoggerObserver

- (void)logger:(GMConsoleLogger *)logger didReceiveLogMessage:(NSString *)logMessage {
    
    [self performSelectorOnMainThread:@selector(appendLogMessage:) withObject:logMessage waitUntilDone:NO];
}

#pragma mark - Handle network request status

- (void)handleNetworkRequestSuccess:(NSNotification *)notification {
    
    //GMAlertView *alert = [[GMAlertView alloc] initWithViewController:self title:nil message:GMLocalizedString(@"Did posted") cancelButtonTitle:GMLocalizedString(@"OK") otherButtonTitles:nil];
    //[alert show];
}

- (void)handleNetworkRequestError:(NSNotification *)notification {
    
    //GMAlertView *alert = [[GMAlertView alloc] initWithViewController:self title:nil message:GMLocalizedString(@"Failed to post") cancelButtonTitle:GMLocalizedString(@"OK") otherButtonTitles:nil];
    //[alert show];
}

@end

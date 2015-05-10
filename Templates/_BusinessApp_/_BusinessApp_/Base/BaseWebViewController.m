//
//  BaseWebViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [self showScreenActivityIndicator];
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self hideScreenActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self hideScreenActivityIndicator];
}

@end

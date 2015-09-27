//
//  CountryPickerViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 26/05/15.
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

#import "CountryPickerViewController.h"
#import "EMCCountryPickerController.h"
#import "UIView+Autolayout.h"

@interface CountryPickerViewController () <EMCCountryDelegate> {
    
    EMCCountryPickerController *_pickerController;
}

@end

@implementation CountryPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
}

#pragma mark - Protected

- (void)commonInit {
    
    [super commonInit];
    
    _pickerController = [[EMCCountryPickerController alloc] init];
    _pickerController.countryDelegate = self;
}

- (void)prepareUI {
    
    if ([self isPresentedModally]) {
        
        [self.view addSubview:_pickerController.view];
        
        // Add picker constraints
        [_pickerController.view viewAddTopSpace:0 containerView:self.view];
        [_pickerController.view viewAddLeadingSpace:0 containerView:self.view];
        [_pickerController.view viewAddTrailingSpace:0 containerView:self.view];
        [_pickerController.view viewAddBottomSpace:0 containerView:self.view];
        
    } else {
        
        [self.view addSubview:_pickerController.view];
        
        // Add picker constraints
        [_pickerController.view viewAddTopSpace:0 containerView:self.view];
        [_pickerController.view viewAddLeadingSpace:0 containerView:self.view];
        [_pickerController.view viewAddTrailingSpace:0 containerView:self.view];
        [_pickerController.view viewAddBottomSpace:0 containerView:self.view];
        
        // Need to apply this fix other top offet appears for searchDisplayController's tableView:
        // http://stackoverflow.com/questions/20731360/strange-uisearchdisplaycontroller-view-offset-behavior-in-ios-7-when-embedded-in
        _pickerController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self addChildViewController:_pickerController];
    [self didMoveToParentViewController:self];
}

#pragma mark - EMCCountryDelegate

- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry {
    
    [self close];
    
    [_delegate didSelectCountryCode:chosenCountry.countryCode];
}

#pragma mark - Private

- (void)close {
    
    [_pickerController removeFromParentViewController];
    
    if ([self isPresentedModally]) {
    
        [self dismissModalViewControllerAnimated:YES];
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)isPresentedModally {
    
    return ((self.navigationController) ? NO : YES);
}

@end

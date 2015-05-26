//
//  CountryPickerViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 26/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "CountryPickerViewController.h"
//#import "CountryPicker.h"
#import "EMCCountryPickerController.h"
#import "UIView+Autolayout.h"
#import "UIToolbar+Custom.h"

@interface CountryPickerViewController () <EMCCountryDelegate> {
    
    EMCCountryPickerController *_pickerController;
}

@end

@implementation CountryPickerViewController

- (void)commonInit {
    
    [super commonInit];
    
    _pickerController = [[EMCCountryPickerController alloc] init];
    _pickerController.countryDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
}

#pragma mark - EMCCountryDelegate

- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry {
    
    [self close];
}

#pragma mark - Helpers

- (void)prepareUI {
    
    if ([self isPresentedModally]) {
        
        CGFloat toolbarHeight = 44.0f;
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        [toolbar createAndSetBarButtonCancelWithTarget:self selector:@selector(close)];
        
        [self.view addSubview:toolbar];
        [self.view addSubview:_pickerController.view];
        
        // Add toolbar constraints
        CGFloat statusBarHeight = [self statusBarFrameViewRect:self.view].size.height;
        [toolbar viewAddTopSpace:statusBarHeight containerView:self.view];
        [toolbar viewAddLeadingSpace:0 containerView:self.view];
        [toolbar viewAddTrailingSpace:0 containerView:self.view];
        [toolbar viewAddHeight:toolbarHeight];
        [toolbar viewAddVerticalSpace:0 toBottomView:_pickerController.view containerView:self.view];
        
        // Add picker constraints
        //[_pickerController.view viewAddTopSpace:toolbarHeight containerView:self.view];
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

- (CGRect)statusBarFrameViewRect:(UIView*)view {
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    //CGRect statusBarWindowRect = [view.window convertRect:statusBarFrame fromWindow: nil];
    //CGRect statusBarViewRect = [view convertRect:statusBarWindowRect fromView: nil];
    
    return statusBarFrame;//statusBarViewRect;
}

@end

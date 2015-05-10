//
//  TermsConditionsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "TermsConditionsViewController.h"

@interface TermsConditionsViewController ()

@end

@implementation TermsConditionsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Render static labels
    [self prepareUI];
    
    // Load data
    [self loadModel];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Log user behaviour
    [self.analyticsManager logScreen:kAnalyticsManagerScreenTermsConditions];
}

- (void)prepareUI {
    
    [super prepareUI];
    
    self.title = GMLocalizedString(@"TermsAndConditions_Title");
    self.lblTitle.text = self.title;
}

- (void)renderUI {
    
    [super renderUI];
    
    //if (self.model.isLoaded) {
        
        [self.webView loadRequest:_model.urlRequest];
    //}
}

- (void)loadModel {
    
    [super loadModel];
    
    [self renderUI];
}

@end

//
//  PhotoDetailsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/24/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "PhotoDetailsModel.h"

#define kPhotoDetailsViewControllerTitle @"PhotoDetails"

@interface PhotoDetailsViewController ()

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Render static labels
    [self prepareUI];
    
    // Initialize model
    [self loadModel];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Log user behaviour
    [self.analyticsManager logScreen:kAnalyticsManagerScreenPhotoDetails];
}

#pragma mark - Helpers

- (void)loadModel {
    
    [super loadModel];
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf showScreenActivityIndicator];
    
    [_model loadData:^(BOOL success, id result, NSError *error) {
        
        [weakSelf hideScreenActivityIndicator];
        
        if (success) {
            
            // Render UI
            [weakSelf renderUI];
            
        } else {
            
            // Show refresh button when error happens
            // ...
        }
    }];
}

- (void)prepareUI {
    
    [super prepareUI];
    
    // Set title
    self.title = GMLocalizedString(kPhotoDetailsViewControllerTitle);
}

- (void)renderUI {
    
    [super renderUI];
    
    // Download image
    [ImageDownloader downloadImageWithUrl:_model.image.imageUrl forImageView:_imageView loadingPlaceholder:kContentPlaceholderImage failedPlaceholder:kContentPlaceholderImage activityIndicatorView:_imageActivityIndicatorView];
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

@end

//
//  PhotoDetailsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/24/15.
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

#pragma mark - Protected methods

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

#pragma mark - IBActions

- (IBAction)addToFavoritesPressed:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [_model addToFavoritesWithCallback:^(BOOL success, id result, NSError *error) {
        
        [weakSelf.messageBarManager showMessageWithTitle:GMLocalizedString(@"Added") description:GMLocalizedString(@"This photo was added to favorites")
                                                    type:MessageBarMessageTypeInfo
                                                duration:1.5f
                                                callback:^{
                                                    
                                                    // ...
                                                }];
    }];
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

@end

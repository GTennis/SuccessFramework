//
//  LaunchViewController.m
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

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protected methods

- (void)commonInit {
    
    [super commonInit];
    
    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    // Use and set the same launch image as screen background image
    NSString *launchImageName = [self launchImageNameForOrientation:self.interfaceOrientation];
    _backgroundImageView.image = [UIImage imageNamed:launchImageName];
    
    // Proceed to app after a couple of seconds
    [self performSelector:@selector(close) withObject:nil afterDelay:1.0f];
}

- (void)renderUI {
    
    [super renderUI];
    
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    // ...
}

#pragma mark - Helpers

- (void)close {
    
    if ([_delegate respondsToSelector:@selector(didFinishShowingCustomLaunch)]) {
        
        [_delegate didFinishShowingCustomLaunch];
    }
}

// Used from: http://stackoverflow.com/a/27797958/597292
- (NSString *)launchImageNameForOrientation:(UIInterfaceOrientation)orientation {
    
    CGSize viewSize = self.view.bounds.size;
    NSString *viewOrientation = @"Portrait";
    
    // Adjust for landscape mode
    if (UIDeviceOrientationIsLandscape(orientation)) {
        
        // Remove later when iOS 7 is not needed.
        if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
            
            viewSize = CGSizeMake(viewSize.height, viewSize.width);
        }
        
        viewOrientation = @"Landscape";
    }
    
    // Extract loaded launch images
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    // Loop through loaded launch images
    for (NSDictionary *dict in imagesDict) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        // Return if launch image is found in loaded plist
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            
            return dict[@"UILaunchImageName"];
    }
    
    return nil;
}

@end

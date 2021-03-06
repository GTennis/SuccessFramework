//
//  WalkthroughViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 27/05/15.
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

#import "WalkthroughViewController.h"
#import "WalkthroughModel.h"

@interface WalkthroughViewController ()

@end

@implementation WalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Render static labels
    [self prepareUI];
    
    // Initialize model
    [self loadModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protected -

- (void)prepareUI {
    
    [super prepareUI];
}

- (void)renderUI {
    
    [super renderUI];
}

- (void)loadModel {
    
    [super loadModel];
    
    [_model loadData:^(BOOL success, id result, NSError *error) {
        
        // Loading model will set flag about app's first time launch
    }];
}

#pragma mark - Public -

#pragma mark IBActions

- (IBAction)skipPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didFinishShowingWalkthrough)]) {
        
        [_delegate didFinishShowingWalkthrough];
    }
}

@end

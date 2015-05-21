//
//  ContactsViewController_ipad.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ContactsViewController_ipad.h"

@interface ContactsViewController_ipad ()

@end

@implementation ContactsViewController_ipad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    __weak typeof (UIView *) weakBackgroundMaskView = _backgroundMaskView;
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        weakBackgroundMaskView.alpha = 0.6f;
        
    } completion:nil];
}

#pragma mark - IBOutlets

- (IBAction)outsideContentViewTapPressed:(id)sender {
    
    _backgroundMaskView.alpha = 0;
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

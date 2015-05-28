//
//  TopModalNavigationBar.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 28/05/15.
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

#import "TopModalNavigationBar.h"

@implementation TopModalNavigationBar

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // Currently supporting single rotation (landscape for iPad, portrait for iPhone).
    // TODO: Check this link for rotation issues if need to support multiple orientations: http://stackoverflow.com/questions/4688137/ios-navigation-bars-titleview-doesnt-resize-correctly-when-phone-rotates
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Prepare UI
    [_cancelButton setTitle:GMLocalizedString(kCancelKey) forState:UIControlStateNormal];
    
    // Add identifiers for functional tests
    NSString *buttonName = [NSString stringWithFormat:@"%@ScreenToolbarCancelButton", NSStringFromClass([self class])];
    self.cancelButton.isAccessibilityElement = YES;
    self.cancelButton.accessibilityLabel = buttonName;
    self.cancelButton.accessibilityIdentifier = buttonName;
    
    NSString *labelName = [NSString stringWithFormat:@"%@ScreenToolbarTitleLabel", NSStringFromClass([self class])];
    self.titleLabel.isAccessibilityElement = YES;
    self.titleLabel.accessibilityLabel = labelName;
    self.titleLabel.accessibilityIdentifier = labelName;
}

- (void)showCancelButton {
    
    _backButton.hidden = YES;
    _cancelButton.hidden = NO;
}

- (void)showBackButton {
    
    _cancelButton.hidden = YES;
    _backButton.hidden = NO;
}

+ (void)applyStyleForModalNavigationBar:(UINavigationBar *)navigationBar {
    
    navigationBar.translucent = NO;
    
    //[[UINavigationBar appearance] setBarTintColor:kColorGrayLight1];
}

#pragma mark - IBActions

- (IBAction)backPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedBackModal)]) {
        
        [_delegate didPressedBackModal];
    }
}

- (IBAction)cancelPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedCancelModal)]) {
        
        [_delegate didPressedCancelModal];
    }
}

@end

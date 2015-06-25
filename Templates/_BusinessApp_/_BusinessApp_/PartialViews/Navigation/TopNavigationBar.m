//
//  TopNavigationBar.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
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

#import "TopNavigationBar.h"

@implementation TopNavigationBar

- (void)dealloc {
    
    _delegate = nil;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // Currently supporting single rotation (landscape for iPad, portrait for iPhone).
    // TODO: Check this link for rotation issues if need to support multiple orientations: http://stackoverflow.com/questions/4688137/ios-navigation-bars-titleview-doesnt-resize-correctly-when-phone-rotates
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Add identifiers for functional tests
    NSString *buttonName = [NSString stringWithFormat:@"%@ScreenToolbarCancelButton", NSStringFromClass([self class])];
    self.menuButton.isAccessibilityElement = YES;
    self.menuButton.accessibilityLabel = buttonName;
    self.menuButton.accessibilityIdentifier = buttonName;
    
    NSString *labelName = [NSString stringWithFormat:@"%@ScreenToolbarTitleLabel", NSStringFromClass([self class])];
    self.titleLabel.isAccessibilityElement = YES;
    self.titleLabel.accessibilityLabel = labelName;
    self.titleLabel.accessibilityIdentifier = labelName;
}

#pragma mark - Public -

- (void)showMenuButton {
    
    _backButton.hidden = YES;
    _menuButton.hidden = NO;
}

- (void)showBackButton {
    
    _backButton.hidden = NO;
    _menuButton.hidden = YES;
}

+ (void)applyStyleForNavigationBar:(UINavigationBar *)navigationBar {
    
    navigationBar.translucent = NO;
    
    //[[UINavigationBar appearance] setBarTintColor:kColorGrayLight1];
}

#pragma mark IBActions

- (IBAction)contactsPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedContacts)]) {
        
        [_delegate didPressedContacts];
    }
}

- (IBAction)backPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedBack)]) {
        
        [_delegate didPressedBack];
    }
}

- (IBAction)menuPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedMenu)]) {
        
        [_delegate didPressedMenu];
    }
}

@end

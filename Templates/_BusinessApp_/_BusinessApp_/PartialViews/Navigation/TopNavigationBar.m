//
//  TopNavigationBar.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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
    
    [[UINavigationBar appearance] setBarTintColor:kColorGrayLight2];
    
    // Currently supporting single rotation (landscape for iPad, portrait for iPhone).
    // TODO: Check this link for rotation issues if need to support multiple orientations: http://stackoverflow.com/questions/4688137/ios-navigation-bars-titleview-doesnt-resize-correctly-when-phone-rotates
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    // The code deals with the following issue: navigation bar leaves some small blank margin space on the left and right sides of custom titleView. The workaround is protect and make width always be full width
    
    CGRect rect = frame;
    CGFloat newWidth = frame.size.width;
    
    // This statement will always return size in portrait
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    // Remove left margin space
    rect.origin.x = 0;
    
    // If running in landscape mode
    if (newWidth > screenSize.width) {
        
        // Adjusting to full width
        newWidth = screenSize.height;
        
        // portrait mode
    } else {
        
        // Adjusting to full width
        newWidth = screenSize.width;
    }
    
    // Set adjusted full width
    rect.size.width = newWidth;
    
    // Super
    [super setFrame:rect];
}

#pragma mark - Public

+ (void)applyStyleForNavigationBar:(UINavigationBar *)navigationBar {
    
    navigationBar.translucent = NO;
    
    //[[UINavigationBar appearance] setBarTintColor:kColorGrayLight1];
}

#pragma mark - IBActions

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

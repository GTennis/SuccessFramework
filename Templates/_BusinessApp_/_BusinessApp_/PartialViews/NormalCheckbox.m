//
//  NormalCheckbox.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 11/22/15.
//  Copyright © 2015 Gytenis Mikulėnas 
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

#import "NormalCheckbox.h"

@interface NormalCheckbox () {
    
    NSString *_title;
    UIColor *_titleColor;
    UIColor *_selectedTitleColor;
}

@end

@implementation NormalCheckbox

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor context:(id)context {
    
    self = [super init];
    if (self) {
        
        _context = context;
        _title = title;
        _titleColor = titleColor;
        _selectedTitleColor = selectedTitleColor;
        
        [self commonInit];
    }
    return self;
}

- (void)setIsOn:(BOOL)isOn {
    
    _isOn = isOn;
    
    [self setIconWithState:isOn];
}

#pragma mark - Protected -

- (void)commonInit {
    
    [self setIconWithState:_isOn];
    
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    if (_title) {
        
        [self setTitle:_title forState:UIControlStateNormal];
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10.0f, 0, 0);
    }
    
    if (_titleColor) {
        
        [self setTitleColor:_titleColor forState:UIControlStateNormal];
    }
}

#pragma mark - Private -

- (void)setIconWithState:(BOOL)isOn {
    
    UIImage *image = nil;
    
    if (isOn) {
        
        image = [UIImage imageNamed:@"iconCheckboxSelected"];
        
        if (_selectedTitleColor) {
            
            [self setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
        }
        
    } else {
        
        image = [UIImage imageNamed:@"iconCheckboxNotSelected"];
        
        if (_titleColor) {
            
            [self setTitleColor:_titleColor forState:UIControlStateNormal];
        }
    }
    
    [self setImage:image forState:UIControlStateNormal];
}

- (void)buttonPressed {
    
    self.isOn = !self.isOn;
    
    [_delegate normalCheckbox:self didSelectWithContext:_context];
}

// http://stackoverflow.com/a/17806333/597292
- (CGSize)intrinsicContentSize {
    
    CGSize s = [super intrinsicContentSize];
    
    return CGSizeMake(s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
    
}

@end

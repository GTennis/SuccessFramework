//
//  UIToolbar+Custom.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
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

#import "UIToolbar+Custom.h"

@implementation UIToolbar (Custom)

- (UIBarButtonItem *)createAndSetBarButtonToBackWithTarget:(id)target selector:(SEL)selector {
    
    // TODO:
    // Change demo with normal implementation
    
    /*CGFloat buttonWidth = 60.0f;
    CGFloat buttonHeight = 44.0f;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon_Back"]];
    [imageView sizeToFit];
    CGRect rect = imageView.frame;
    rect.origin.y = 20;
    rect.origin.x = -15;
    imageView.frame = rect;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, buttonWidth, buttonHeight)];
    label.font = kFontNormalWithSize(18);
    label.text = GMLocalizedString(@"Back");
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kColorRed;
    label.backgroundColor = [UIColor clearColor];
    [button addSubview:label];
    [button addSubview:imageView];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Item" style:UIBarButtonItemStyleBordered target:self action:@selector(itemButton2Pressed:)];
    
    self.items = @[leftButton];
    
    // Need to set color again because setItems: reset background color to white
    self.barTintColor = kColorGrayLight2;
    
    return leftButton;*/
    
    return nil;
}

- (UIBarButtonItem *)createAndSetBarButtonCancelWithTarget:(id)target selector:(SEL)selector {
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:target action:selector];
    
    leftButton.title = GMLocalizedString(@"Cancel");
    [leftButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorRed} forState:UIControlStateNormal];
    
    self.items = @[leftButton];
    
    return leftButton;
}

@end
//
//  UIToolbar+Custom.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
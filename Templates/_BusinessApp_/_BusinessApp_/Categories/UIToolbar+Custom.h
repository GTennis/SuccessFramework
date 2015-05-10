//
//  UIToolbar+Custom.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@interface UIToolbar (Custom)

- (UIBarButtonItem *)createAndSetBarButtonToBackWithTarget:(id)target selector:(SEL)selector;
- (UIBarButtonItem *)createAndSetBarButtonCancelWithTarget:(id)target selector:(SEL)selector;

@end
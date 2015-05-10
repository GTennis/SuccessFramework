//
//  GMAlertView.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "GMAlertView.h"

@implementation GMAlertView

- (id)initWithViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (self) {
        for (NSString *buttonTitle in otherButtonTitles) {
            [self addButtonWithTitle:buttonTitle];
        }
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.completion) {
        self.completion(buttonIndex==self.cancelButtonIndex, buttonIndex);
        self.completion = nil;
    }
}

/*- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
 
 if (self.completion) {
 self.completion(buttonIndex==self.cancelButtonIndex, buttonIndex);
 self.completion = nil;
 }
 }*/

@end

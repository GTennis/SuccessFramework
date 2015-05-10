//
//  GMAlertView.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/10/15.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMAlertView : UIAlertView /*NSObject*/

@property (copy, nonatomic) void (^completion)(BOOL, NSInteger);

- (id)initWithViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

@end

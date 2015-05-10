//
//  APIClientErrorHandler.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMAlertView;

@interface APIClientErrorHandler : NSObject

#warning TODO...

+ (GMAlertView *)alertViewFromAPIErrorNotification:(NSNotification *)notification presentingViewController:(UIViewController *)viewController;

@end

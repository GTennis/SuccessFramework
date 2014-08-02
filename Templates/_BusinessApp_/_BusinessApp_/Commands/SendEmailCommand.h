//
//  SendEmailCommand.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 20/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "CommandProtocol.h"

@interface SendEmailCommand : NSObject <CommandProtocol>

- (instancetype)initWithViewController:(UIViewController *)viewController subject:(NSString *)subject message:(NSString *)message recipients:(NSArray *)recipients;

// Use if message is created later than object itself
@property (nonatomic, strong) NSString *message;

@end

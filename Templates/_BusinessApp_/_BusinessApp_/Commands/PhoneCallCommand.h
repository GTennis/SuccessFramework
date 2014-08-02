//
//  PhoneCallCommand.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 20/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "CommandProtocol.h"

@interface PhoneCallCommand : NSObject <CommandProtocol>

- (instancetype)initWithPhoneNumberString:(NSString *)phoneNumberString;

@end

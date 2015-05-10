//
//  KeychainManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/11/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@protocol KeychainManagerProtocol <NSObject>

- (BOOL)setAuthentificationToken:(NSString *)token;
- (NSString *)authentificationToken:(NSString *)token;

@end

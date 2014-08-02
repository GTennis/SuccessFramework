//
//  CommandProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 20/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

@protocol CommandProtocol <NSObject>

- (BOOL)canExecute:(NSError **)error;
- (void)execute;

@end

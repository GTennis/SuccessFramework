//
//  NSObject+Description.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//
//  For Debugging only
//

#import <Foundation/Foundation.h>

@interface NSObject(Description)

#ifdef DEBUG

// Overrides native method and prints out all properties and their variables
// Used from: http://stackoverflow.com/questions/6376344/generic-objective-c-description-method-to-print-ivar-values
//- (NSString *)description;

#endif

@end
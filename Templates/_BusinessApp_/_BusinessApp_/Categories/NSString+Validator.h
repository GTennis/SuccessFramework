//
//  NSString+Validator.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validator)

- (NSString *)removeAllHtmlTags;
- (BOOL)isMailValid;
- (BOOL)isPasswordValid;
- (NSString *)UTF8EncodedString;
- (BOOL)isValidUrlString;

@end

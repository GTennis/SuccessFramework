//
//  NSString+Validator.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NSString+Validator.h"

@implementation NSString (Validator)

- (NSString *)removeAllHtmlTags {
    
    NSString *allTagsPattern = @"<[^>]+>";
    NSString *breakTagPattern = @"<br[^>]+>"; // <br>, <br />, <br/ >
    NSRange range;
    NSString *result = self;
    
    while ((range = [result rangeOfString:breakTagPattern options:NSRegularExpressionSearch]).location != NSNotFound) {
        result = [result stringByReplacingCharactersInRange:range withString:@"\n"];
    }
    while ((range = [result rangeOfString:allTagsPattern options:NSRegularExpressionSearch]).location != NSNotFound) {
        result = [result stringByReplacingCharactersInRange:range withString:@""];
    }
    return result;
}
 
- (BOOL)isMailValid {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isPasswordValid {
    
    return self.length > 0;
}

// Converts national symbols into URL compatible symbols and codes. The method should for preparing all user entered texts when passing to the backend
- (NSString *)UTF8EncodedString {
    
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 kCFStringEncodingUTF8);
}

- (BOOL)isValidUrlString {
    
    NSURL *url = [NSURL URLWithString:self];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    return [NSURLConnection canHandleRequest:request];
}

@end

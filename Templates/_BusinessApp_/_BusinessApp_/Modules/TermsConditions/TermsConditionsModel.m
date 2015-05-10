//
//  TermsConditionsModel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "TermsConditionsModel.h"

@implementation TermsConditionsModel

- (NSURLRequest *)urlRequest {
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://help.github.com/articles/github-terms-of-service/"]];
}

@end

//
//  ImageObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject

@synthesize title = _title;
@synthesize author = _author;
@synthesize imageUrl = _imageUrl;

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        _title = dict[kImageTitleKey];
        _author = dict[kImageAuthorKey];
        _imageUrl = dict[kImageUrlKey];
    }
    return self;
}

@end

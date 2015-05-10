//
//  ImagesObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ImagesObject.h"

@implementation ImagesObject

@synthesize list = _list;

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        NSArray *images = dict[kImagesKey];
        NSMutableArray *resultList = [[NSMutableArray alloc] initWithCapacity:images.count];
        ImageObject *image = nil;
        
        for (NSDictionary *imageDic in images) {
            
            image = [[ImageObject alloc] initWithDict:imageDic];
            [resultList addObject:image];
        }
        
        _list = (NSArray <ImageObject>*) resultList;
    }
    
    return self;
}

@end

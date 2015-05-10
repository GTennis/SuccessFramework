//
//  ImagesObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ParsableObject.h"
#import "ImageObject.h"

#define kImagesKey @"images"

@protocol ImagesObject <ParsableObject>

@property (nonatomic, strong) NSArray <ImageObject> *list;

@end

@interface ImagesObject : NSObject <ImagesObject>

@end

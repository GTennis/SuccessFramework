//
//  ImageObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ParsableObject.h"

#define kImageTitleKey @"title"
#define kImageAuthorKey @"author"
#define kImageUrlKey @"url"

@protocol ImageObject <ParsableObject>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *imageUrl;

@end

@interface ImageObject : NSObject <ImageObject>

@end

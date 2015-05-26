//
//  PhotoDetailsModel.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/24/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseModel.h"
#import "ImageObject.h"

@interface PhotoDetailsModel : BaseModel

@property (nonatomic, strong) ImageObject *image;

@end

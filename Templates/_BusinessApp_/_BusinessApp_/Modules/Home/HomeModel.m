//
//  HomeModel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (void)willStartModelLoading:(Callback)callback {
    
    [self.backendAPIClient getTopImagesWithTag:nil callback:callback];
}

- (void)didFinishModelLoadingWithData:(id)data {

    // Store data
    _images = (ImagesObject *)data;
}

@end

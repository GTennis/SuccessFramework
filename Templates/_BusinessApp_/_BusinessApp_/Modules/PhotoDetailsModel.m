//
//  PhotoDetailsModel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/24/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "PhotoDetailsModel.h"

@implementation PhotoDetailsModel

- (void)onDataLoading:(Callback)callback {
    
    // Passed parameters when creating viewControllers, are injected as context to viewController and its model in viewControllerFactory
    callback(YES, self.context, nil);
}

- (void)onDataLoaded:(id)data {
    
    // Store data
    _image = (ImageObject *)data;
}

@end

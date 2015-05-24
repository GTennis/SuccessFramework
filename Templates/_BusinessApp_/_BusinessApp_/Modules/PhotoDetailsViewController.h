//
//  PhotoDetailsViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/24/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseViewController.h"

@class PhotoDetailsModel;

@interface PhotoDetailsViewController : BaseViewController

@property (nonatomic, strong) PhotoDetailsModel *model;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *imageActivityIndicatorView;

@end

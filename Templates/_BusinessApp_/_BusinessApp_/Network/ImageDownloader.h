//
//  ImageDownloader.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject

+ (NSURLRequest *)imageRequestWithUrlString:(NSString *)urlString size:(CGSize)size;
+ (void)downloadImageWithUrl:(NSString *)imageUrl forImageView:(UIImageView *)imageView loadingPlaceholder:(NSString *)loadingPlaceholder failedPlaceholder:(NSString *)failedPlaceholder activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;

@end

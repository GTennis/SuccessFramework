//
//  ImageDownloader.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas All rights reserved.
//

#import "ImageDownloader.h"
#import "UIimageView+AFNetworking.h"

@implementation ImageDownloader

+ (NSURLRequest *)imageRequestWithUrlString:(NSString *)urlString size:(CGSize)size {
    
    if (!urlString.length) {
        
        return nil;
    }
    
    // Escape spaces and other symbols
    NSString *properlyEscapedURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *sizeString = [NSString stringWithFormat:@"%dx%d", (int)size.width*(int)scale, (int)size.height*(int)scale];
    NSString *placeholder = @"Original";
    if([properlyEscapedURL rangeOfString:placeholder].location != NSNotFound) {
        properlyEscapedURL = [properlyEscapedURL stringByReplacingOccurrencesOfString:placeholder withString:sizeString];
    }
    
    // Create request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:properlyEscapedURL]];
    
    // Add image header
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    // Return
    return request;
}

+ (void)downloadImageWithUrl:(NSString *)imageUrl forImageView:(UIImageView *)imageView loadingPlaceholder:(NSString *)loadingPlaceholder failedPlaceholder:(NSString *)failedPlaceholder activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    
    NSURLRequest *request = [ImageDownloader imageRequestWithUrlString:imageUrl size:imageView.bounds.size];
    
    // Return if bad url
    if (!request) {
        
        // Show failed placeholder image in case there's no image
        UIImage *image = [UIImage imageNamed:failedPlaceholder];
        ANIMATE_IMAGE_TRANSITION_FOR_IMAGEVIEW(imageView);
        
        return;
    }
    
    // Prepare references
    __weak typeof(UIImageView *) weakImageView = imageView;
    __weak typeof(NSString *) weakFailedPlaceholder = failedPlaceholder;
    __weak typeof(UIActivityIndicatorView *) weakActivityIndicatorView = activityIndicatorView;
    
    // Start indicator
    weakActivityIndicatorView.hidesWhenStopped = YES;
    [weakActivityIndicatorView startAnimating];
    
    // Download image
    [imageView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:loadingPlaceholder]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  
                                  // Stop indicator
                                  [weakActivityIndicatorView stopAnimating];
                                  
                                  // Perform animation
                                  ANIMATE_IMAGE_TRANSITION_FOR_IMAGEVIEW(weakImageView);
                                  
                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  
                                  DLog(@"Failed to download image: %@", request.URL);
                                  
                                  // Stop indicator
                                  [weakActivityIndicatorView stopAnimating];
                                  
                                  // Show failed placeholder
                                  if (weakFailedPlaceholder) {
                                      
                                      UIImage *image = [UIImage imageNamed:weakFailedPlaceholder];
                                      ANIMATE_IMAGE_TRANSITION_FOR_IMAGEVIEW(weakImageView);
                                  }
                              }];
}

@end

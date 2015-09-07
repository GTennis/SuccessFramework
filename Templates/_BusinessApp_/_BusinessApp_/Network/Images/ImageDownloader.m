//
//  ImageDownloader.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
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
    
    DDLogDebug(@"Will download image: %@", request.URL);
    
    // Return if bad url
    if (!request) {
        
        DDLogWarn(@"Unable to download image: bad url");
        
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
                                  
                                  DDLogWarn(@"Failed to download image: %@", request.URL);
                                  
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

//
//  HomeListItemView.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
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

#import "HomeListItemView.h"
#import "ImageObject.h"

@interface HomeListItemView () {
    
    ImageObject *_image;
}

@end

@implementation HomeListItemView

#pragma mark - Public -

- (void)renderWithObject:(ImageObject *)image {
    
    // Store object
    _image = image;
    
    // Render UI
    _titleLabel.text = image.filename;
    _authorLabel.text = image.author;
    
    // Clear previous image before downloading a new
    _imageView.image = nil;
    
    // Download image
    [ImageDownloader downloadImageWithUrl:image.urlString forImageView:_imageView loadingPlaceholder:kContentPlaceholderImage failedPlaceholder:kContentPlaceholderImage activityIndicatorView:_activityIndicatorView];
}

#pragma mark IBActions

- (IBAction)cellPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedWithImage:)]) {
        
        [_delegate didPressedWithImage:_image];
    }
}

@end

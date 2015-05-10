//
//  HomeListItemView.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "HomeListItemView.h"
#import "ImageObject.h"

@interface HomeListItemView () {
    
    ImageObject *_image;
}

@end

@implementation HomeListItemView

- (void)renderWithObject:(ImageObject *)image {
    
    // Store object
    _image = image;
    
    // Render UI
    _titleLabel.text = image.title;
    _authorLabel.text = image.author;
    
    // Download image
    [ImageDownloader downloadImageWithUrl:image.imageUrl forImageView:_imageView loadingPlaceholder:kContentPlaceholderImage failedPlaceholder:kContentPlaceholderImage activityIndicatorView:_activityIndicatorView];
}

#pragma mark - IBActions

- (IBAction)cellPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressedWithImage:)]) {
        
        [_delegate didPressedWithImage:_image];
    }
}


@end

//
//  HomeListItemView.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

@class ImageObject;

@protocol HomeListItemViewDelegate <NSObject>

- (void)didPressedWithImage:(ImageObject *)image;

@end

@interface HomeListItemView : UICollectionViewCell

@property (nonatomic, weak) id<HomeListItemViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet NormalLabel *titleLabel;
@property (weak, nonatomic) IBOutlet NormalLabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (void)renderWithObject:(ImageObject *)image;

@end

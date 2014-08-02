//
//  TopNavigationBar.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/10/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopNavigationBarDelegate <NSObject>

- (void)didPressedContacts;
- (void)didPressedBack;
- (void)didPressedMenu;

@end

@interface TopNavigationBar : UIView

@property (weak, nonatomic) id<TopNavigationBarDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *userActionButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *contactsButton;

+ (void)applyStyleForNavigationBar:(UINavigationBar *)navigationBar;

@end

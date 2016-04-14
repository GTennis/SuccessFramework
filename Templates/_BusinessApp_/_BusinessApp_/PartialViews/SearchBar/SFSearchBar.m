//
//  SFSearchBar.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 14/04/16.
//  Copyright © 2016 Gytenis Mikulėnas 
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

#import "SFSearchBar.h"

#define kOKSearchBarCustomSearchIconTraillingOffset -15.0f
#define kOKSearchBarCustomSearchIconBottomOffset -10.0f

@interface SFSearchBar () <UISearchBarDelegate> {
    
}

@property (nonatomic, strong) UIImageView *customSearchIconImageView;
@property (nonatomic, strong) id externalDelegate;
@property (nonatomic) BOOL isShownCustomSearchIcon;

@end

@implementation SFSearchBar

#pragma mark - Public -

- (void)setDelegate:(id<UISearchBarDelegate>)delegate {
    
    _externalDelegate = delegate;
    
    [super setDelegate:self];
}

- (void)setIsShownCustomSearchIcon:(BOOL)isShownCustomSearchIcon {
    
    if (isShownCustomSearchIcon) {
        
        __weak typeof (self) weakSelf = self;
        
        [UIView animateWithDuration:0.2f delay:0.2f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            weakSelf.customSearchIconImageView.alpha = 1.0f;
            
        } completion:nil];
        
    } else {
        
        _customSearchIconImageView.alpha = 0;
    }
}

#pragma mark - Protected -

#pragma mark Override

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // Adjust search style
    self.backgroundColor = [UIColor clearColor];
    self.backgroundImage = [[UIImage alloc] init];
    
    // Customize cancel color
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:kColorBlue];
    
    UIImage *searchBarIconImage = [UIImage imageNamed:@"iconSearchBar"];
    _customSearchIconImageView = [[UIImageView alloc] initWithImage:searchBarIconImage];
    
    // Change search bar icon. Using a workaround:
    
    // 1. Hide search icon
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setLeftViewMode:UITextFieldViewModeNever];
    
    // For changing cursor color
    //[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:kColorBlueLight];
    
    // 2. Add search image as subView
    [self addSubview:_customSearchIconImageView];
    
    // 3. Add needed constraints
    [_customSearchIconImageView viewAddBottomSpace:kOKSearchBarCustomSearchIconBottomOffset containerView:self];
    [_customSearchIconImageView viewAddTrailingSpace:kOKSearchBarCustomSearchIconTraillingOffset containerView:self];
    
    // Change search bar icon
    //[_searchBar setImage:customSearcBarIconImage forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [[UITextField appearanceWhenContainedIn:[self class], nil] setTextColor:kColorBlue];
    [[UITextField appearanceWhenContainedIn:[self class], nil] setBackgroundColor:kColorGrayLight];
}

#pragma mark - Private -

#pragma mark Forwarding events

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    BOOL result = YES;
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        
        result = [_externalDelegate searchBarShouldBeginEditing:searchBar];
    }
    
    return result;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self setIsShownCustomSearchIcon:NO];
    [self setShowsCancelButton:YES animated:YES];
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        
        [_externalDelegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    BOOL result = YES;
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        
        result = [_externalDelegate searchBarShouldEndEditing:searchBar];
    }
    
    return result;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    // Search bar shows clear button even after resign first responder if there's a text
    // Therefore we won't show search icon on top
    if (!searchBar.text.length) {
        
        [self setIsShownCustomSearchIcon:YES];
    }
    
    [self setShowsCancelButton:NO animated:YES];
    
    [self endEditing:YES];
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        
        [_externalDelegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        
        [_externalDelegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.text = @"";
    [self setShowsCancelButton:NO animated:YES];
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        
        [_externalDelegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]) {
        
        [_externalDelegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    
    if ([_externalDelegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]) {
        
        [_externalDelegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;  {
    
    if ([_externalDelegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        
        [_externalDelegate searchBar:searchBar textDidChange:searchText];
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    BOOL result = YES;
    
    if ([_externalDelegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
        
        result = [_externalDelegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    
    return result;
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
    if ([_externalDelegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]) {
        
        [_externalDelegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}

@end

//
//  NormalButton.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NormalButton.h"

@implementation NormalButton

#pragma mark - Overrided

- (void)initializeProperties {
    
    [super initializeProperties];
    
    self.borderSize = kButtonBorderSize;
    self.borderColor = kButtonBorderColor;
    
    self.cornerRadius = kButtonCornerRadius;
    
    self.backgroundNormalColor = kButtonBackgroundColorNormalState;
    self.textNormalColor = kButtonTextColorNormalState;
    
    self.backgroundHighlightedColor = kButtonBackgroundColorHighlightedState;
    self.textHighlightedColor = kButtonTextColorHighlightedState;
    
    self.backgroundDisabledColor = kButtonBackgroundColorDisabledState;
    self.textDisabledColor = kButtonTextColorDisabledState;
    
    self.fontName = kButtonTextFont;
    self.fontSize = kButtonTextFontSize;
}

@end

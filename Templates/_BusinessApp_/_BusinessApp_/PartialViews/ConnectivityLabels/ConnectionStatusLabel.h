//
//  ConnectionStatusLabel.h
//  MyInsurrance
//
//  Created by Gytenis Mikulenas on 11/6/15.
//  Copyright © 2015 OKOTTA Germany GmbH. All rights reserved.
//

#define kConnectionStatusLabelTag 20151106

// Corners
#define kConnectionStatusLabelBorderCornerRadius 4.0f

// Border
#define kConnectionStatusLabelBorderWidth 1.0f
#define kConnectionStatusLabelBorderColor [kColorGrayDark CGColor]

// Text
#define kConnectionStatusLabelTextColor kColorWhite
#define kConnectionStatusLabelBackgroundColor kColorGrayDark
#define kConnectionStatusLabelTextFont kFontNormal
#define kConnectionStatusLabelTextSize 15.0f

#define kConnnectionStatusLabelMessageKey @"NoIternetMessage"

#define kConnectionStatusLabelPhoneNumber @"123456789"

@interface ConnectionStatusLabel : UIButton

@end

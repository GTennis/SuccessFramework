//
//  ConstColors.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/4/14.
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

// RGB color macro
#define rgbColor(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB color macro with alpha
#define rgbColorColorWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// Use as less colors as possible. All colors should be consistent all over user interface. Make UX and designers stick with UI consistency

// Colors are setted in the IB as user defined runtime attributes and supported by BackgroundColor categories
#define kColorGrayLightName  @"ColorGrayLight"
#define kColorGrayLight      rgbColor(0x999999)

#define kColorGrayLightName1  @"ColorGrayLight1"
#define kColorGrayLight1      rgbColor(0xDDDDDD)

#define kColorGrayLightName2  @"ColorGrayLight2"
#define kColorGrayLight2    rgbColor(0xF1F1F1)

#define kColorGrayDarkName  @"ColorGrayDark"
#define kColorGrayDark     rgbColor(0x363636)

#define kColorGrayName  @"ColorGray"
#define kColorGray     rgbColor(0x606060)

#define kColorBlackName  @"ColorBlack"
#define kColorBlack     rgbColor(0x000000)

#define kColorRedLightName @"ColorRedLight"
#define kColorRedLight      rgbColor(0xFD4545)

#define kColorRedName  @"ColorRed"
#define kColorRed      rgbColor(0xFF0000)

#define kColorRedDarkName @"ColorRedDark"
#define kColorRedDark      rgbColor(0x9C0707)

#define kColorBlueName  @"ColorBlue"
#define kColorBlue      rgbColor(0x0000FF)

#define kColorWhiteName  @"ColorWhite"
#define kColorWhite      rgbColor(0xFFFFFF)

#define kColorYellowName  @"ColorYellow"
#define kColorYellow     rgbColor(0xFFFF00)

#define kColorGreenName  @"ColorGreen"
#define kColorGreen      rgbColor(0x46AF65)

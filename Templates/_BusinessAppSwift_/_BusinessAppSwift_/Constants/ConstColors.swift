//
//  ConstColors.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 23/10/16.
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

// RGB color macro
func rgbColor(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

// RGB color macro with alpha
func rgbColorColorWithAlpha(rgbValue: UInt, alpha: Float) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha)
    )
}

// Use as less colors as possible. All colors should be consistent all over user interface. Make UX and designers stick with UI consistency

// Colors are setted in the IB as user defined runtime attributes and supported by BackgroundColor categories
let kColorGrayLightName = "ColorGrayLight"
let kColorGrayLight     = rgbColor(rgbValue: 0x999999)

let kColorGrayLightName1 = "ColorGrayLight1"
let kColorGrayLight1    = rgbColor(rgbValue: 0xDDDDDD)

let  kColorGrayLightName2 = "ColorGrayLight2"
let  kColorGrayLight2     = rgbColor(rgbValue: 0xF1F1F1)

let  kColorGrayDarkName = "ColorGrayDark"
let  kColorGrayDark     = rgbColor(rgbValue: 0x363636)

let  kColorGrayName = "ColorGray"
let  kColorGray     = rgbColor(rgbValue: 0x606060)

let  kColorBlackName = "ColorBlack"
let  kColorBlack     = rgbColor(rgbValue: 0x000000)

let  kColorRedLightName = "ColorRedLight"
let  kColorRedLight     = rgbColor(rgbValue: 0xFD4545)

let  kColorRedName = "ColorRed"
let  kColorRed     = rgbColor(rgbValue: 0xFF0000)

let  kColorRedDarkName = "ColorRedDark"
let  kColorRedDark     = rgbColor(rgbValue: 0x9C0707)

let  kColorBlueName = "ColorBlue"
let  kColorBlue     = rgbColor(rgbValue: 0x0000FF)

let  kColorWhiteName = "ColorWhite"
let  kColorWhite     = rgbColor(rgbValue: 0xFFFFFF)

let  kColorYellowName = "ColorYellow"
let  kColorYellow     = rgbColor(rgbValue: 0xFFFF00)

let  kColorGreenName = "ColorGreen"
let  kColorGreen     = rgbColor(rgbValue: 0x46AF65)

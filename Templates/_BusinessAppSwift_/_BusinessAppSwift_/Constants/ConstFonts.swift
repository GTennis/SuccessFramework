//
//  ConstFonts.swift
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

// Font types are setted in IB as user defined runtime attributes and supported by FontType categories

// Store custom fonts in Resources/Fonts folder. For each font add an entry (filename.extension) under UIAppFonts (Fonts provided by application) inside plist

let kFontBoldType = "FontBold"
let kFontBold = "Glockenspiel"

let kFontNormalType = "FontNormal"
let kFontNormal = "Glockenspiel"

// How to add custom fonts: http://codewithchris.com/common-mistakes-with-adding-custom-fonts-to-your-ios-app/
// How to find the name of added custom font: run this code in didFinishLaunching to find out all available fonts, including added custom ones:
/*for family: String in UIFont.familyNames
{
    print("\(family)")
    for names: String in UIFont.fontNames(forFamilyName: family)
    {
        print("== \(names)")
    }
}*/

// Aliases for fontWithName: method
func fontBoldWithSize(size: CGFloat)->UIFont {
    
    return UIFont(name: kFontBold, size: size)!
}

func fontNormalWithSize(size: CGFloat)->UIFont {
    
    return UIFont(name: kFontNormal, size: size)!
}

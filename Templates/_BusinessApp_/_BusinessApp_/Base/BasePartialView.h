//
//  PSCustomViewFromXib.h
//  CustomView
//
//  Created by Paul Solt on 4/28/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//
//  Modified by Gytenis Mikulenas:
//
//  1. Renamed class name and file, property type
//  2. Added support for universal app: iPad/iPhone subclass picking

#import <UIKit/UIKit.h>

@interface BasePartialView : UIView

+ (CGSize)sizeForView;

@end

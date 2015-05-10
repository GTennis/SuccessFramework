//
//  ConstAliases.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#define REGISTRY [Registry sharedRegistry]
#define isIpad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kAnimationDuration 0.5f
#define ANIMATE_IMAGE_TRANSITION_FOR_IMAGEVIEW(imageView) [UIView transitionWithView:imageView duration:kAnimationDuration/2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{imageView.image = image;} completion:NULL];

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

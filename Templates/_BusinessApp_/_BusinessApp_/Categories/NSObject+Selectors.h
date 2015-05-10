//
//  NSObject+Selectors.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

// Allows to use more up to three parameters in performSelector

@interface NSObject (Selectors)

- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 waitUntilDone:(BOOL)wait;
- (void)performSelector:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3;
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2;
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3;
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 withObject:(id)arg4;

@end

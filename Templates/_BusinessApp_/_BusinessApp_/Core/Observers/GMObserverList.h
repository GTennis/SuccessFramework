//
//  GMObserverList.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/13/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMObserverList : NSObject

@property (nonatomic, readonly) id observedSubject; // Observed list model
@property (nonatomic, readonly) NSArray *observers;

- (id)initWithObservedSubject:(id)observedSubject;

// Observers:
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (BOOL)containsObserver:(id)observer;

// Generic notification method. Mostly used for list and details models
- (void)notifyObserversForSelector:(SEL)observerSelector;
- (void)notifyObserversForSelector:(SEL)observerSelector withObject:(id)object;
- (void)notifyObserversForSelector:(SEL)observerSelector withObject1:(id)object1 object2:(id)object2;

@end

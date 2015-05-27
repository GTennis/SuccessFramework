//
//  GMObserverList.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/13/14.
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

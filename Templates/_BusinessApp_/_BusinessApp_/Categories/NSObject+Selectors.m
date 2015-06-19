//
//  NSObject+Selectors.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
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

#import "NSObject+Selectors.h"

@implementation NSObject (Selectors)

// Invokes selector on main thread with one argument
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 waitUntilDone:(BOOL)wait {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    if (!methodSignature) {
	
        return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation retainArguments];
	[invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

// Invokes selector on main thread with two arguments
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    if (!methodSignature) {
	
        return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation setArgument:&arg2 atIndex:3];
	[invocation retainArguments];
	[invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

// Invokes selector on main thread with three arguments
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 waitUntilDone:(BOOL)wait {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    if (!methodSignature) {
	
        return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation setArgument:&arg2 atIndex:3];
	[invocation setArgument:&arg3 atIndex:4];
	[invocation retainArguments];
	[invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

// Invokes selector with three arguments
- (void)performSelector:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
	if (!methodSignature) {
        
		return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation setArgument:&arg2 atIndex:3];
	[invocation setArgument:&arg3 atIndex:4];
	[invocation retainArguments];
	[invocation performSelector:@selector(invoke) withObject:nil];
}

// Invokes selector on another thread with two arguments
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    if (!methodSignature) {
	
        return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation setArgument:&arg2 atIndex:3];
	[invocation retainArguments];
    [invocation performSelectorInBackground:@selector(invoke) withObject:nil];
}

// Invokes selector on another thread with three arguments
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    if (!methodSignature) {
	
        return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation setArgument:&arg2 atIndex:3];
    [invocation setArgument:&arg3 atIndex:4];
	[invocation retainArguments];
    [invocation performSelectorInBackground:@selector(invoke) withObject:nil];
}

// Invokes selector on another thread with four arguments
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 withObject:(id)arg4 {
    
	// Extract method signature
	NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    if (!methodSignature) {
	
        return;
    }
	
	// Create and invoke selector
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:target];
	[invocation setSelector:selector];
	[invocation setArgument:&arg1 atIndex:2];
	[invocation setArgument:&arg2 atIndex:3];
    [invocation setArgument:&arg3 atIndex:4];
    [invocation setArgument:&arg4 atIndex:5];
	[invocation retainArguments];
    [invocation performSelectorInBackground:@selector(invoke) withObject:nil];
}

@end

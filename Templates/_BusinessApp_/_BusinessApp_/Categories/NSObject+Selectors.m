//
//  NSObject+Selectors.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NSObject+Selectors.h"

@implementation NSObject (Selectors)

// Invokes selector on main thread with one argument
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 waitUntilDone:(BOOL)wait
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo retainArguments];
	[invo performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

// Invokes selector on main thread with two arguments
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo setArgument:&arg2 atIndex:3];
	[invo retainArguments];
	[invo performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

// Invokes selector on main thread with three arguments
- (void)performSelectorOnMainThread:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 waitUntilDone:(BOOL)wait
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo setArgument:&arg2 atIndex:3];
	[invo setArgument:&arg3 atIndex:4];
	[invo retainArguments];
	[invo performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

// Invokes selector with three arguments
- (void)performSelector:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo setArgument:&arg2 atIndex:3];
	[invo setArgument:&arg3 atIndex:4];
	[invo retainArguments];
	[invo performSelector:@selector(invoke) withObject:nil];
}

// Invokes selector in other thread with two arguments
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo setArgument:&arg2 atIndex:3];
	[invo retainArguments];
    [invo performSelectorInBackground:@selector(invoke) withObject:nil];
}

// Invokes selector in other thread with three arguments
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo setArgument:&arg2 atIndex:3];
    [invo setArgument:&arg3 atIndex:4];
	[invo retainArguments];
    [invo performSelectorInBackground:@selector(invoke) withObject:nil];
}

// Invokes selector in other thread with four arguments
- (void)performSelectorInBackground:(SEL)selector onTarget:(id)target withObject:(id)arg1 withObject:(id)arg2 withObject:(id)arg3 withObject:(id)arg4
{
	// Extrack method signature:
	NSMethodSignature *sig = [target methodSignatureForSelector:selector];
	if (!sig)
		return;
	
	// Invoke selector:
	NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setTarget:target];
	[invo setSelector:selector];
	[invo setArgument:&arg1 atIndex:2];
	[invo setArgument:&arg2 atIndex:3];
    [invo setArgument:&arg3 atIndex:4];
    [invo setArgument:&arg4 atIndex:5];
	[invo retainArguments];
    [invo performSelectorInBackground:@selector(invoke) withObject:nil];
}

@end

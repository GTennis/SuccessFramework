//
//  main.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/12/13.
//  Copyright (c) 2012 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        
        BOOL isRunningTests = (NSClassFromString(@"XCTestCase") != nil);
        
        if (isRunningTests) {
            
            UIApplicationMain(argc, argv, nil, @"AppDelegate4UnitTests");
            
        } else {
            
            UIApplicationMain(argc, argv, nil, @"AppDelegate");
        }
    }
}

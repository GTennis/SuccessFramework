//
//  HomeModelTests.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 5/23/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "HomeModel.h"
#import "BackendAPIClient.h"
#import "ImagesObject.h"

@interface HomeModelTests : XCTestCase

@end

@implementation HomeModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_loadData_CallbackIsCalled {
    
    HomeModel *model = [[HomeModel alloc] init];
    
    id backendAPIClientMock = OCMProtocolMock(@protocol(BackendAPIClientProtocol));
    
    // Creating needed wrapper block for mock
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
        // we define the sucess block:
        void (^callback)(BOOL success, id result, NSError *error) = nil;
        
        [invocation getArgument: &callback atIndex: 3];
        
        callback(YES, nil, nil);
    };
    
    // Override getTopImagesWithTag:callback: and make it always perform proxy block and return success
    [[[backendAPIClientMock expect] andDo:proxyBlock] getTopImagesWithTag:[OCMArg any] callback:[OCMArg any]];
    
    // Assign mock
    model.backendAPIClient = backendAPIClientMock;

    // Create flag for checking
    __block BOOL isCalled = NO;
    
    // Create passed callback
    Callback callback = ^(BOOL success, id result, NSError *error){
        
        isCalled = YES;
    };
    
    // Perform tested method
    [model loadData:callback];
    
    // Verify
    XCTAssertTrue(isCalled, @"Callback not called");
}

- (void)test_willStartModelLoading_BackendAPIClientIsCalled {
    
    HomeModel *model = [[HomeModel alloc] init];
    id backendAPIClientMock = OCMProtocolMock(@protocol(BackendAPIClientProtocol));
    model.backendAPIClient = backendAPIClientMock;
    
    // Expect
    [[backendAPIClientMock expect] getTopImagesWithTag:[OCMArg any] callback:[OCMArg any]];
    
    // Perform tested method
    [model loadData:nil];
    
    // Verify
    [backendAPIClientMock verify];
}

- (void)test_didFinishModelLoadingWithData_StoresLoadedData {
    
    HomeModel *model = [[HomeModel alloc] init];
    
    id backendAPIClientMock = OCMProtocolMock(@protocol(BackendAPIClientProtocol));
    
    // Will simulate loaded data
    ImagesObject *images = [[ImagesObject alloc] init];
    ImageObject *image1 = [[ImageObject alloc] init];
    ImageObject *image2 = [[ImageObject alloc] init];
    images.list = (NSArray<ImageObject> *) @[image1, image2];
    
    // Creating needed wrapper block for mock
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
        // we define the sucess block:
        void (^callback)(BOOL success, id result, NSError *error) = nil;
        
        [invocation getArgument: &callback atIndex: 3];
        
        callback(YES, images, nil);
    };
    
    // Override getTopImagesWithTag:callback: and make it always perform proxy block and return success
    [[[backendAPIClientMock expect] andDo:proxyBlock] getTopImagesWithTag:[OCMArg any] callback:[OCMArg any]];
    
    // Assign mock
    model.backendAPIClient = backendAPIClientMock;
    
    // Create passed callback
    Callback callback = ^(BOOL success, id result, NSError *error){
        
    };
    
    // Perform tested method
    [model loadData:callback];
    
    XCTAssert(model.images == images, @"Loaded images are not stored");
    XCTAssert(model.images.list.count == 2, @"Wrong number of images");
}

// Check method not called
- (void)test_loadData_didFinishModelLoadingWithDataNotCalled {
    
    HomeModel *model = [[HomeModel alloc] init];
    id modelMock = OCMPartialMock(model);
    
    // Create passed callback
    Callback callback = ^(BOOL success, id result, NSError *error){
        
    };

    [[modelMock reject] didFinishModelLoadingWithData:[OCMArg any]];
    
    // Perform tested method
    [model loadData:callback];
    
    // Verify
    [modelMock verify];
}

@end

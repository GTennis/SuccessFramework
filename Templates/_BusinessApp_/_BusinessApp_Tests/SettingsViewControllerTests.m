//
//  SettingsViewControllerTests.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 25/06/15.
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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SettingsViewController.h"
#import "SettingsModel.h"

@interface SettingsViewControllerTests : XCTestCase {
    
    SettingsViewController *_viewController;
}

@end

@implementation SettingsViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [self createViewController];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = nil;
    _viewController = nil;
}

- (void)test_viewDidLoad_calls_initialMethods {
    
    id mock = OCMPartialMock(_viewController);
    
    [[mock expect] prepareUI];
    
    [_viewController viewDidLoad];
    [mock verify];
}

- (void)test_prepareUI_setsCorrectUI {
    
    [_viewController prepareUI];
    
    XCTAssert([_viewController.title isEqualToString:GMLocalizedString(kSettingsViewControllerTitleKey)], @"Wrong text");
}

- (void)test_notificationLocalizationHasChanged_reloadsUI {
    
    id mock = OCMPartialMock(_viewController);
    
    [[mock expect] prepareUI];
    
    [_viewController notificationLocalizationHasChanged];
    
    [mock verify];
}

- (void)test_englishPressed_CallsModelMethod {
    
    id mock = OCMClassMock([SettingsModel class]);
    
    _viewController.model = mock;
    
    [[mock expect] setLanguageEnglish];
    
    [_viewController englishPressed:nil];
    
    [mock verify];
}

- (void)test_germanPressed_CallsModelMethod {
    
    id mock = OCMClassMock([SettingsModel class]);
    
    _viewController.model = mock;
    
    [[mock expect] setLanguageGerman];
    
    [_viewController germanPressed:nil];
    
    [mock verify];
}

#pragma mark - Helpers

- (void)createViewController {
    
    _viewController = [[SettingsViewController alloc] initWithCrashManager:nil analyticsManager:nil messageBarManager:nil viewControllerFactory:nil context:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = _viewController;
}

@end

//
//  _BusinessAppSwift_Tests.swift
//  _BusinessAppSwift_Tests
//
//  Created by Gytenis Mikulenas on 06/09/16.
//  Copyright © 2016 Gytenis Mikulėnas
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

import XCTest
@testable import _BusinessAppSwift_

class _BusinessAppSwift_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDisplayUserShouldDisplayNameAndPhoneAndProfilePhotoWithMocks() {
        
        // Used from: http://clean-swift.com/to-mock-or-not-to-mock/
        
        // Given
        /*let profilePhoto = UIImage(named: "JohnDoe")!
        let viewModel = UserViewModel(name: "John Doe", phone: "123-456-7890", profilePhoto: profilePhoto)
        
        let nameLabelMock = UILabelMock()
        userViewController.nameLabel = nameLabelMock
        let phoneLabelMock = UILabelMock()
        userViewController.phoneLabel = phoneLabelMock
        let profilePhotoImageViewMock = UIImageViewMock()
        userViewController.profilePhotoImageView = profilePhotoImageViewMock
        
        // When
        userViewController.displayUser(viewModel)
        
        // Then
        let displayedName = nameLabelMock.text
        XCTAssert(nameLabelMock.textSetterWasCalled)
        XCTAssertEqual(displayedName, "John Doe", "Displaying an user should display the name in the name label")
        
        let displayedPhone = phoneLabelMock.text
        XCTAssert(phoneLabelMock.textSetterWasCalled)
        XCTAssertEqual(displayedPhone, "123-456-7890", "Displaying an user should display the phone in the phone label")
        
        let displayedProfilePhoto = profilePhotoImageViewMock.image
        XCTAssert(profilePhotoImageViewMock.imageSetterWasCalled)
        XCTAssertEqual(displayedProfilePhoto, profilePhoto, "Displaying an user should display the profile photo in the profile photo image view")*/
    }
}

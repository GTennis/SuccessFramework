//
//  NLAssertEqualOptional.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 26/10/2016.
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

//
//  NLAssertEqualOptional.swift
//  NLAssertEqualOptionalExample
//
//  Created by Nikola Lajic on 10/3/14.
//  Copyright (c) 2014 codecentric. All rights reserved.
//

// Used from: https://blog.codecentric.de/en/2014/10/extending-xctestcase-testing-swift-optionals/
// https://github.com/MrNickBarker/NLAssertEqualOptional

import Foundation
import XCTest

extension XCTestCase {
    func NLAssertEqualOptional<T : Equatable>(expression1: @autoclosure () -> T?, _ expression2: @autoclosure () -> T, _ message: String? = nil, file: String = #file, line: UInt = #line) {
        var m = "NLAssertEqualOptional failed - "
        if let e = expression1() {
            let e2 = expression2()
            if e != e2 {
                if let message = message {
                    m += message
                }
                else {
                    m += "Optional (\(e)) is not equal to (\(e2))"
                }
                self.recordFailure(withDescription: m, inFile: file, atLine: line, expected: true)
            }
        }
        else {
            self.recordFailure(withDescription: m + "Optional value is empty", inFile: file, atLine: line, expected: true)
        }
    }
    
    func NLAssertEqualOptional<T : Equatable>(expression1: @autoclosure () -> [T]?, _ expression2: @autoclosure () -> [T], _ message: String? = nil, file: String = #file, line: UInt = #line) {
        var m = "NLAssertEqualOptional failed - "
        if let e = expression1() {
            let e2 = expression2()
            if e != e2 {
                if let message = message {
                    m += message
                }
                else {
                    m += "Optional (\(e)) is not equal to (\(e2))"
                }
                self.recordFailure(withDescription: m, inFile: file, atLine: line, expected: true)
            }
        }
        else {
            self.recordFailure(withDescription: m + "Optional value is empty", inFile: file, atLine: line, expected: true)
        }
    }
    
    func NLAssertEqualOptional<T, U : Equatable>(expression1: @autoclosure () -> [T : U]?, _ expression2: @autoclosure () -> [T : U], _ message: String? = nil, file: String = #file, line: UInt = #line) {
        var m = "NLAssertEqualOptional failed - "
        if let e = expression1() {
            let e2 = expression2()
            if e != e2 {
                if let message = message {
                    m += message
                }
                else {
                    m += "Optional (\(e)) is not equal to (\(e2))"
                }
                self.recordFailure(withDescription: m, inFile: file, atLine: line, expected: true)
            }
        }
        else {
            self.recordFailure(withDescription: m + "Optional value is empty", inFile: file, atLine: line, expected: true)
        }
    }
}

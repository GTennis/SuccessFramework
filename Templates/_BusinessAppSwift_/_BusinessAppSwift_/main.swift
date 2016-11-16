//
//  Copyright © 2016 mokacoding. All rights reserved.
//
// https://forums.developer.apple.com/thread/46405
// http://www.mokacoding.com/blog/prevent-unit-tests-from-loading-app-delegate-in-swift/
// https://github.com/mokacoding/TestAppDelegateExample

import UIKit

private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    nil,
    delegateClassName()
)

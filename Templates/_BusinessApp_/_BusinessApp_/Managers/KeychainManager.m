//
//  KeychainManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/11/14.
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

#import "KeychainManager.h"
#import "UICKeyChainStore.h"

#define kKeychainManagerAuthentificationTokenKey @"authentificationToken"

@interface KeychainManager () {
    
    UICKeyChainStore *_keychainStore;
}

@end

@implementation KeychainManager

#pragma mark - KeychainManagerProtocol -

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        _keychainStore = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
    }
    return self;
}

#pragma mark - KeychainManagerProtocol -

- (NSError *)setAuthentificationToken:(NSString *)token {
    
    NSError *error = nil;
    
    if (token.length > 0) {
        
        [_keychainStore setString:token forKey:kKeychainManagerAuthentificationTokenKey error:&error];
        
        if (error) {
            
            DDLogError(@"KeychainManager: unable to store token: %@", error.localizedDescription);
        }
        
    } else {
        
        [_keychainStore removeItemForKey:kKeychainManagerAuthentificationTokenKey error:&error];
        
        if (error) {
            
            DDLogError(@"KeychainManager: unable to clear stored token: %@", error.localizedDescription);
        }
    }
    
    return error;
}

- (NSString *)authentificationToken {
    
    NSError *error = nil;
    
    NSString *token = [_keychainStore stringForKey:kKeychainManagerAuthentificationTokenKey error:&error];
    
    if (error) {
        
        DDLogError(@"KeychainManager: unable to retrieve stored token: %@", error.localizedDescription);
    }
    
    return token;
}

@end

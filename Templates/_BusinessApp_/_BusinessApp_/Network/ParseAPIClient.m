//
//  ParseAPIClient.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 01/07/15.
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

#import "ParseAPIClient.h"
#import "ParseAPIConfig.h"
#import <Parse/Parse.h>
#import "UserObject.h"

@implementation ParseAPIClient

- (id)init {
    
    self = [super init];
    if (self) {
        
        [Parse setApplicationId:kParseAPIClientAppId
                      clientKey:kParseAPIClientClienKey];
        
    }
    return self;
}

#pragma mark - ParseAPIClientProtocol -

#pragma mark Push notification related

- (void)registerPushNotificationToken:(NSData *)token {
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:token];
    [currentInstallation saveInBackground];
}

- (void)handlePushNotificationWithReceivedUserInfo:(NSDictionary *)userInfo application:(UIApplication *)application {
    
    if (application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground) {
        
        // Looks like Parse SDK has an issue. Suppose the app is closed and we receive push notification. If user clicks on system displayed top alert then Parse won't track this opening even if the method is called. It needs some time to start the app. Everything works without delay when app is in background
        
        // Also, please note, push notification can be tracked double time:
        // a) when user clicks on system displayed top alert and opens the app.
        // b) the user can close the app, open notification center and click on the notification which will open the app again and will result in second track.
        
        [self performSelector:@selector(trackRemoteNotificationUsingUserInfo:) withObject:userInfo afterDelay:5.0f];
        //[self logAppOpeningFromPushNotification];
    }
}

#pragma mark User related

- (void)loginUser:(UserObject *)userObject callback:(Callback)callback{
    
    // Try to do login. If it fails the we will create new user. If sucesses then everything is ok.
    [PFUser logInWithUsernameInBackground:userObject.email password:userObject.password
                                    block:^(PFUser *user, NSError *error) {
                                        
                                        // If parseUser exists ...
                                        if (user) {
                                            
                                            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                                            [self checkAndCreateRelationIfNeededBetweenUser:user andInstallation:currentInstallation callback:callback];
                                            
                                        // Othwerwise need to create new parseUser
                                        } else {
                                            
                                            // Prepare new parseUser
                                            PFUser *newUser = [PFUser user];
                                            newUser.username = userObject.email;
                                            newUser.password = userObject.password;
                                            //user.email = @"email@example.com";
                                            
                                            // Create new parseUser
                                            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                
                                                // If sucess then add relation from device installation to this user
                                                if (!error) {
                                                    
                                                    PFUser *newUser = [PFUser currentUser];
                                                    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                                                    [self checkAndCreateRelationIfNeededBetweenUser:newUser andInstallation:currentInstallation callback:callback];
                                                    
                                                } else {
                                                    
                                                    callback(NO, nil, error);
                                                }
                                            }];
                                        }
                                    }];
}

- (void)logoutUserWithCallback:(Callback)callback {
    
    [PFUser logOut];
    
    callback(YES, nil, nil);
}

- (void)signUpUser:(UserObject *)userObject callback:(Callback)callback {
    
    // Prepare parseUser
    PFUser *newUser = [PFUser user];
    newUser.username = userObject.email;
    newUser.password = userObject.password;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        // If success then add relation from device installation to this user
        if (!error) {
            
            PFUser *createdUser = [PFUser currentUser];
            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            
            [self checkAndCreateRelationIfNeededBetweenUser:createdUser andInstallation:currentInstallation callback:callback];
            
        } else {
            
            callback(NO, nil, error);
        }
    }];
}

#pragma mark - Private -

- (void)checkAndCreateRelationIfNeededBetweenUser:(PFUser *)user andInstallation:(PFInstallation *)installation callback:(Callback)callback {
    
    // Check if user was already logged in using this device
    PFQuery *relDeviceInstallationUserQuery = [PFQuery queryWithClassName:kParseAPIClientRelDeviceInstallationUserDataStorageName];
    [relDeviceInstallationUserQuery whereKey:kParseAPIClientRelDeviceInstallationUserUserIdRefKey equalTo:user.objectId];
    [relDeviceInstallationUserQuery whereKey:kParseAPIClientRelDeviceInstallationUserDeviceInstallationIdRefKey equalTo:installation.objectId];
    
    [relDeviceInstallationUserQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            if (!objects.count) {
                
                // Need to create this relation
                PFObject *relDeviceInstallationUser = [PFObject objectWithClassName:kParseAPIClientRelDeviceInstallationUserDataStorageName];
                relDeviceInstallationUser[kParseAPIClientRelDeviceInstallationUserUserIdRefKey] = user.objectId;
                relDeviceInstallationUser[kParseAPIClientRelDeviceInstallationUserDeviceInstallationIdRefKey] = installation.objectId;
                [relDeviceInstallationUser saveInBackground];
            }
            
            callback(YES, nil, nil);
            
        } else {
            
            callback(NO, nil, error);
        }
    }];
}

- (void)trackRemoteNotificationUsingUserInfo:(NSDictionary *)userInfo {
    
    [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
}

/*- (void)logAppOpeningFromPushNotification {
    
    NSString *className = @"AppOpeningsFromPushNotifications";
    NSString *appOpeningEventCountName = @"count";
    
    PFQuery *appOpenings = [PFQuery queryWithClassName:className];
    
    [appOpenings findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        PFObject *appOpeningEvent = nil;
        NSInteger appOpeningEventCount = 0;
        
        if (objects.count) {
            
            appOpeningEvent = objects.firstObject;
            appOpeningEventCount = [appOpeningEvent[appOpeningEventCountName] integerValue];
            
        } else {
            
            appOpeningEvent = [PFObject objectWithClassName:className];
        }
        
        appOpeningEventCount++;
        appOpeningEvent[appOpeningEventCountName] = @(appOpeningEventCount);
        [appOpeningEvent saveInBackground];
    }];
}*/

@end

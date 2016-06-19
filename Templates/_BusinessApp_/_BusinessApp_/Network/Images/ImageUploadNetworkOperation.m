//
//  ImageUploadNetworkOperation.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
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

#import "ImageUploadNetworkOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserManager.h"
#import "ImageObject.h"

@interface ImageUploadNetworkOperation ()

@property (nonatomic, strong) NSString *uploadUrlString;
@property (nonatomic, strong) NSString *loadingPlaceholder;
@property (nonatomic, strong) NSString *failedPlaceholder;
@property (nonatomic, strong) UIActivityIndicatorView *progressBar;

@property (nonatomic, strong) AFHTTPRequestOperation *operation;

@end

@implementation ImageUploadNetworkOperation

- (instancetype)initWithImage:(id<ImageObject>)image uploadUrlString:(NSString *)uploadUrlString loadingPlaceholder:(NSString *)loadingPlaceholder failedPlaceholder:(NSString *)failedPlaceholder progressBar:(UIActivityIndicatorView *)progressBar {
    
    self = [super init];
    if (self) {
        
        _image = image;
        _uploadUrlString = uploadUrlString;
        _loadingPlaceholder = loadingPlaceholder;
        _failedPlaceholder = failedPlaceholder;
        _progressBar = progressBar;
    }
    return self;
}

- (void)performWithCallback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    if (!_image || !_image.image) {
        
        NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:@"Cannot download empty image"};
        NSError *error = [NSError errorWithDomain:@"ImageUpload" code:0 userInfo:userInfoDict];
        callback(NO, nil, error);
        return;
    }
    
    weakSelf.status = kImageUploadStatusInProgress;
    
    NSString *token = [self userManager].user.token;
    
    // Create filename
    _image.filename = [NSString stringWithFormat:@"image%f.jpeg", [[NSDate date] timeIntervalSince1970]];
    
    AFHTTPRequestOperationManager *operationManager = [self operationManager];
    
    [operationManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    _operation = [operationManager POST:weakSelf.uploadUrlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //NSData *imgData= UIImageJPEGRepresentation(weakSelf.image.image, 0.5);
        
        CGFloat compression = 0.9f;
        CGFloat maxCompression = 0.1f;
        int maxFileSize = 1*1024*1024;
        
        NSData *imageData = UIImageJPEGRepresentation(weakSelf.image.image, compression);
        
        while ([imageData length] > maxFileSize && compression > maxCompression) {
            compression -= 0.1;
            imageData = UIImageJPEGRepresentation(weakSelf.image.image, compression);
        }
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:weakSelf.image.filename mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DDLogWarn(@"Response: %@", responseObject);
        
        NSString *createdResourceRestUrl = operation.response.allHeaderFields[@"location"];
        //id<ImageObject> uploadedImage = [[ImageObject alloc] initWithDict:responseObject];

        weakSelf.image.fileId = createdResourceRestUrl;
        
        //weakSelf.image.fileId = uploadedImage.fileId;
        //weakSelf.image.filename = uploadedImage.filename;
        //weakSelf.image.urlString = uploadedImage.urlString;
        
        weakSelf.status = kImageUploadStatusFinished;
        callback(YES, weakSelf, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DDLogWarn(@"Error: %@", error);

        weakSelf.status = kImageUploadStatusFailed;
        weakSelf.error = error;

        // For unknown reason AFNetworking returns -1011 in error.code instead of 401 (But it shows 401 in error's description). Therefore adding explicit extraction:
        // http://stackoverflow.com/a/34280269/597292
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = response.statusCode;
        
        if (statusCode == kNetworkRequestUnauthorizedCode) {
            
            [weakSelf performSelector:@selector(notifyObserversWithUnauthorizedError:) withObject:error afterDelay:1];
            
        } else {
            
            callback(NO, nil, error);
        }
    }];
}

- (void)notifyObserversWithUnauthorizedError:(NSError *)error {
    
    NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:GMLocalizedString(@"ReloginMessage")};
    NSError *fixedError = [NSError errorWithDomain:error.domain code:kNetworkRequestUnauthorizedCode userInfo:userInfoDict];
    //callback(NO, nil, fixedError);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkRequestErrorNotification object:nil userInfo:@{kNetworkRequestErrorNotificationUserInfoKey:fixedError}];
}

- (void)cancel {
    
    _image.image = nil;
    _image.filename = nil;
    _image.fileId = nil;
    _image.urlString = nil;
    
    _error = nil;
    
    _status = kImageUploadStatusInitial;
    
    if (!_operation.isCancelled) {
        
        [_operation cancel];
    }
}

- (id<UserManagerProtocol>)userManager {
    
    id<UserManagerProtocol> userManager = [REGISTRY getObject:[UserManager class]];
    return userManager;
}

- (AFHTTPRequestOperationManager *)operationManager {
    
    return [AFHTTPRequestOperationManager manager];
}

@end

//
//  CustomAFJSONResponseSerializer.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 25/08/15.
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
//  Partially used from: http://stackoverflow.com/questions/19096556/afnetworking-2-0-afhttpsessionmanager-how-to-get-status-code-and-response-json
//
//  This class helps to add custom network response handling logic.
//  Mostly is usefull for custom error handling,
//  especially when errors are returned using other than HTTP status 2XX

#import "CustomAFJSONResponseSerializer.h"
#import "NSDictionary+JSON.h"
#import "ErrorObject.h"

#define kNetworkResponseSerializerErrorDomain @"CustomNetworkErrorDomain"

@implementation CustomAFJSONResponseSerializer

#pragma mark - Protected -

#pragma mark Override

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    
    if (*error != nil) {
        
        NSInteger httpResponseStatus = [[[*error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        NSString *httpResponseStatusString = [NSString stringWithFormat:@"%ld", (long)httpResponseStatus];
        NSInteger httpResponseStatusFirstDigit = [[httpResponseStatusString substringToIndex:1] integerValue];
        
        // Handle response by first HTTP status digit
        switch (httpResponseStatusFirstDigit) {
                
            case 2:
                
                // Everything is ok.
                break;
                
            case 4:
                
                // Unauthorized
                if (httpResponseStatus == 401) {
                    
                    NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:GMLocalizedString(@"ReloginMessage")};
                    (*error) = [NSError errorWithDomain:kNetworkResponseSerializerErrorDomain code:kNetworkRequestUnauthorizedCode userInfo:userInfoDict];
                    break;
                    
                    // 4XX bad data was passed
                } else {
                    
                    (*error) = [self errorFromDict:JSONObject httpResponseStatus:httpResponseStatus responseData:data];
                    
                    break;
                }
                
                // Override 5XX status with custom text
            case 5: {
                
                NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:GMLocalizedString(@"Server5xxErrorMessage")};
                (*error) = [NSError errorWithDomain:kNetworkResponseSerializerErrorDomain code:httpResponseStatus userInfo:userInfoDict];
                
                break;
            }
                
                // Override any other HTTP status code with custom text
            default: {
                
                NSString *errorString = [@"Unknown HTTP status code: " stringByAppendingString:httpResponseStatusString];
                NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:errorString};
                (*error) = [NSError errorWithDomain:kNetworkResponseSerializerErrorDomain code:httpResponseStatus userInfo:userInfoDict];
                
                break;
            }
        }
        
        return (JSONObject);
        
    } else {
        
        return [((NSDictionary *) JSONObject) dictionaryByRemovingAndReplacingNulls];
    }
}

#pragma mark - Private -

- (NSError *)errorFromDict:(NSDictionary *)dict httpResponseStatus:(NSInteger)httpResponseStatus responseData:(NSData *)responseData {
    
    NSArray *errors = dict[@"errors"];
    NSDictionary *firstErrorDict = errors.firstObject;
    NSString *firstErrorMessage = [NSString stringWithFormat:@"%ld: %@", (long)httpResponseStatus, firstErrorDict[@"message"]];
    
    NSError *result = nil;
    
    if (firstErrorMessage.length > 0) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey: firstErrorMessage}];
        
    } else {
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:responseString};
        
        result = [NSError errorWithDomain:kNetworkResponseSerializerErrorDomain code:httpResponseStatus userInfo:userInfoDict];
    }
    
    return result;
}

@end

//
//  GMAFJSONResponseSerializer.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
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

#import "GMAFJSONResponseSerializer.h"
#import "NSDictionary+JSON.h"
#import "ErrorObject.h"

#define kNetworkResponseSerializerErrorDomain @"CustomNetworkErrorDomain"

@implementation GMAFJSONResponseSerializer

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
                
            // Override 5XX status with custom text
            case 5: {
                
                NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:@"Server is too busy. Try again later"};
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
        
        // Handle response by exact HTTP status
        // Suppose errors are returned via 400
        /*if (httpResponseStatus == 400) {
         
            // Check if we received json responseObject
            if (data) {
                
                NSError *errorDeserializationError = nil;
                NSDictionary *errorsDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorDeserializationError];
                
                // If unable to deserialized error responseObject
                if (errorDeserializationError) {
                    
                    // Overwrite previous error
                    NSString *errorString = [@"Unable to deserialize response: " stringByAppendingString:errorDeserializationError.localizedDescription];
                    NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:errorString};
                    (*error) = [NSError errorWithDomain:kNetworkResponseSerializerErrorDomain code:httpResponseStatus userInfo:userInfoDict];
                    
                } else {
                    
                    NSArray *errorsArray = errorsDic[kNetworkErrorsKey];
                    
                    // Extract first error from the list of errors
                    if (errorsArray.count > 0) {
                        
                        NSDictionary *errorDic = errorsArray[0];
                        (*error) = [NSError errorWithDomain:errorDic[kNetworkErrorCodeKey] code:httpResponseStatus userInfo:nil];
                    }
                }
                
            // If for any reason response body doesn't contain responseObject then just change error code and leave error domain as previous
            } else {
                
                // Overwrite previous error
                (*error) = [NSError errorWithDomain:(*error).domain code:httpResponseStatus userInfo:(*error).userInfo];
            }
            
        }*/
        
        return (JSONObject);
        
    } else {
        
        return [((NSDictionary *) JSONObject) dictionaryByRemovingAndReplacingNulls];
    }
}

@end

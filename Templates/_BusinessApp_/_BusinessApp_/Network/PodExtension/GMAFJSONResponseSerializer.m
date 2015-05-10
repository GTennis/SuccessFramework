//
//  GMAFJSONResponseSerializer.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//
//  Partially used from: http://stackoverflow.com/questions/19096556/afnetworking-2-0-afhttpsessionmanager-how-to-get-status-code-and-response-json

#import "GMAFJSONResponseSerializer.h"
#import "NSDictionary+JSON.h"
#import "ErrorObject.h"

@implementation GMAFJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil) {
        
        NSInteger httpResponseStatus = [[[*error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        NSString *httpResponseStatusString = [NSString stringWithFormat:@"%ld", (long)httpResponseStatus];
        NSInteger httpResponseStatusFirstDigit = [[httpResponseStatusString substringToIndex:1] integerValue];
        
        switch (httpResponseStatusFirstDigit) {
                
            // If received 4XX status code
            case 4: {
                
                if (httpResponseStatus == 401) {
                    
                    // Create and wrap errors into a new error
                    (*error) = [NSError errorWithDomain:@"CustomNetworkErrorDomain" code:httpResponseStatus userInfo:nil];
                    
                // For all other status codes
                } else if (httpResponseStatus == 400) {
                    
                    // Check if we received json responseObject
                    if (data) {
                        
                        NSError *errorDeserializationError = nil;
                        NSDictionary *errorsDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorDeserializationError];
                        
                        // If unable to deserialized error responseObject
                        if (errorDeserializationError) {
                            
                            // Overwrite previous error
                            NSString *errorDomain = [@"Unable to deserialize error responseObject: " stringByAppendingString:errorDeserializationError.localizedDescription];
                            (*error) = [NSError errorWithDomain:errorDomain code:httpResponseStatus userInfo:nil];
                            
                        } else {
                            
                            NSArray *errorsArray = errorsDic[kNetworkErrorsKey];
                            
                            // extract first error from the list of errors
                            if(errorsArray.count > 0) {
                                NSDictionary *errorDic = errorsArray[0];
                                (*error) = [NSError errorWithDomain:errorDic[kNetworkErrorCodeKey] code:httpResponseStatus userInfo:nil];
                            }
                            
                        }
                        
                        // If for any reason response body doesn't contain responseObject then just change error code and leave error domain as previous
                    } else {
                        
                        // Overwrite previous error
                        (*error) = [NSError errorWithDomain:@"Body doesn't contain responseObject" code:httpResponseStatus userInfo:nil];
                    }
                }
                
                break;
            }
                
                // If received 5XX status code
            case 5: {
                
                // Overwrite previous error
                (*error) = [NSError errorWithDomain:@"Ups. Server is very busy. Please try again later" code:httpResponseStatus userInfo:nil];
                
                break;
            }
                
            default:
                break;
        }
        
        return (JSONObject);
    }
    else {
        return [((NSDictionary *) JSONObject) dictionaryByRemovingAndReplacingNulls];
    }
}

@end

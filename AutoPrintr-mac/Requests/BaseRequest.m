//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "BaseRequest.h"
#import "AlertViewManager.h"

@implementation BaseRequest

+ (instancetype)request {
    return [self new];
}

- (NSString *)serverBase {
    return SERVER_BASE_URL;
}

- (NSString *)requestURL {
    return @"";
}

- (NSDictionary *)params {
    return @{
             };
}

- (NSDictionary *)defaultHeaders {
    return @{
             };
}

- (NSData *)fileData {
    return nil;
}

- (RequestMethod)requestMethod {
    return kRequestMethodGET;
}

// Required For Autocomplete

- (void)setSuccess:(RequestSuccessBlock)success {
    _success = success;
}

- (void)setError:(RequestErrorBlock)error {
    _error = error;
}

- (void)setExceptionBlock:(RequestExceptionBlock)exceptionBlock {
    _exceptionBlock = exceptionBlock;
}

- (void)handleException:(NSException *)exception {
    if (self.exceptionBlock) {
        self.exceptionBlock(self,exception);
    }
}

- (BOOL)getDataFromXML {
    return NO;
}

- (BOOL)getResponseData {
    return NO;
}

- (id)successData:(id)data {
    return data;
}

- (void)sendRequest:(id)failureBlock successBlock:(id)successBlock path:(NSString *)path {
    switch ([self requestMethod]) {
        case kRequestMethodGET:
            [self.requestOperationManager GET:path
                                   parameters:[self params]
                                     progress:nil
                                      success:successBlock
                                      failure:failureBlock];
            break;
        case kRequestMethodPOST:
            if ([self fileData]) {
                [self.requestOperationManager POST:path
                                        parameters:[self params]
                         constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                             [formData appendPartWithFileData:[self fileData]
                                                         name:@""
                                                     fileName:@""
                                                     mimeType:@""];
                         }
                                          progress:nil
                                           success:successBlock
                                           failure:failureBlock];
            } else {
                [self.requestOperationManager POST:path
                                        parameters:[self params]
                                          progress:nil
                                           success:successBlock
                                           failure:failureBlock];
            }
            break;
        case kRequestMethodPUT:
            [self.requestOperationManager PUT:path parameters:[self params] success:successBlock failure:failureBlock];
            break;
        case kRequestMethodDELETE:
            [self.requestOperationManager DELETE:path parameters:[self params] success:successBlock failure:failureBlock];
            break;
    }
}


- (void)addHeaders {
    for (NSString *key in self.defaultHeaders.allKeys) {
        [self.requestOperationManager.requestSerializer setValue:self.defaultHeaders[key] forHTTPHeaderField:key];
    }
}

- (BOOL)shouldUseRequestJSONSerializer {
    return NO;
}

- (void)handleError:(NSError *)error {
    if (error.code == -1011) {
        NSData *data = [[error userInfo] objectForKey:@"com.alamofire.serialization.response.error.data"];
        
        
        NSError *error2;
        id messages = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error2];
        
        if (! messages) {
            [[AlertViewManager shared] showAlertWithMessage:@"Error"
                                                 andDetails:error.description];
            return;
        }
        
        if ([messages isKindOfClass:[NSArray class]]) {
            NSArray *messagesArray = (NSArray *)messages;
            if (messagesArray.count > 0) {
                if ([messagesArray[0] isKindOfClass:[NSString class]]) {
                    [[AlertViewManager shared] showAlertWithMessage:@"Error"
                                                         andDetails:messagesArray[0]];
                    return;
                }
                
                NSString *message = @"";
                for (NSDictionary *element in messagesArray) {
                    if (element[@"message"]) {
                        message = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n",element[@"message"]]];
                    } else {
                        message = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n",element]];
                    }
                }
                [[AlertViewManager shared] showAlertWithMessage:@"Error"
                                                     andDetails:message];
            } else {
                [[AlertViewManager shared] showAlertWithMessage:@"Error"
                                                     andDetails:error.description];
            }
        }
        
        if ([messages isKindOfClass:[NSDictionary class]]) {
            NSDictionary *messageDictionary = (NSDictionary *)messages;
            
            NSString *message = @"";
            for (NSDictionary *element in messageDictionary[@"errors"]) {
                if (element[@"message"]) {
                    message = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n",element[@"message"]]];
                } else {
                    message = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n",element]];
                }
            }
            
            [[AlertViewManager shared] showAlertWithMessage:@"Error"
                                                 andDetails:message];
        }
    } else {
        [[AlertViewManager shared] showAlertWithMessage:@"Error"
                                             andDetails:error.description];
    }
}

- (void)runRequest {
    self.requestOperationManager = [AFHTTPSessionManager new];
    self.requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([self shouldUseRequestJSONSerializer]) {
        self.requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    [self addHeaders];
    
    NSString *path = [[self serverBase] stringByAppendingString:[self requestURL]];
    
    __weak BaseRequest *_self = self;
    
    id successBlock = ^(NSURLSessionDataTask *task, id response){
        @try {
            id data = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
            
            if ([self getResponseData]) {
                data = response;
            }
            
            if (_self.success) {
                _self.success(_self, [_self successData:data]);
            }
        }
        @catch (NSException *exception) {
            [self handleException:exception];
        }
    };
    
    id failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        @try {
            if (_self.error) {
                _self.error(_self, error);
                if (_self.hasCustomDisplayErrorMessage == NO) {
                    [_self handleError:error];
                }
            } else {
                [_self handleError:error];
            }
        }
        @catch (NSException *exception) {
            [self handleException:exception];
        }
        
    };
    
    [self sendRequest:failureBlock successBlock:successBlock path:path];
}

- (NSString *)encodeString:(NSString *)text {
    return [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
}

@end

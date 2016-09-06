//
//  BaseRequest.h
//  AutoPrintr-mac
//
//  Copyright (c) 2016 X2 Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

static NSString * const SERVER_BASE_URL = @"http://admin.repairshopr.com/api/v1";
static NSString * const GLOBAL_URL = @"repairshopr.com/api/v1";

typedef enum {
    kRequestMethodGET,
    kRequestMethodPOST,
    kRequestMethodPUT,
    kRequestMethodDELETE
} RequestMethod;

@class BaseRequest;

typedef void(^RequestSuccessBlock)(id request, id response);
typedef void(^RequestErrorBlock)(id request, NSError *error);
typedef void(^RequestExceptionBlock)(id request, NSException *exceptionBlock);

@interface BaseRequest : NSObject

@property (strong, nonatomic) NSString *progressIndicatorTitle;

@property (nonatomic, copy) RequestSuccessBlock success;
@property (nonatomic, copy) RequestErrorBlock error;
@property (nonatomic, copy) RequestExceptionBlock exceptionBlock;
@property (strong, nonatomic) AFHTTPSessionManager *requestOperationManager;
@property (nonatomic) BOOL hasCustomDisplayErrorMessage;

+ (instancetype)request;

- (NSString *)serverBase;
- (NSString *)requestURL;
- (NSDictionary *)params;
- (NSDictionary *)defaultHeaders;
- (RequestMethod)requestMethod;
- (id)successData:(id)data;

- (void)runRequest;
- (void)sendRequest:(id)failureBlock successBlock:(id)successBlock path:(NSString *)path;

- (void)setSuccess:(RequestSuccessBlock)success;
- (void)setError:(RequestErrorBlock)error;
- (void)setExceptionBlock:(RequestExceptionBlock)exceptionBlock;
- (void)handleException:(NSException *)exception;

- (BOOL)getDataFromXML;
- (BOOL)getResponseData;
- (void)addHeaders;

- (NSString *)encodeString:(NSString *)text;

- (BOOL)shouldUseRequestJSONSerializer;

@end

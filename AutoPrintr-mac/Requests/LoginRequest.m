//
//  LoginRequest.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 30/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "LoginRequest.h"
#import "DataManager.h"
#import "User.h"

@interface LoginRequest()
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@end

@implementation LoginRequest

+ (instancetype)requestWithEmail:(NSString *)email password:(NSString *)password {
    LoginRequest *request = [self new];
    
    request.email = email;
    request.password = password;
    
    return request;
}

- (RequestMethod)requestMethod {
    return kRequestMethodPOST;
}

- (NSString *)requestURL {
    return @"/sign_in";
}

- (NSDictionary *)params {
    return @{@"email": self.email,
             @"password": self.password};
}

- (id)successData:(id)data {
    User *user = [User createFromDictionary:data];
    [DataManager shared].loggedInUser = user;
    return user;
}

@end

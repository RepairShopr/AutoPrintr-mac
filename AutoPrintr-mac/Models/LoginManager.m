//
//  LoginManager.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 13/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "LoginManager.h"
#import "DataManager.h"
#import "LoginRequest.h"
#import "GetRegistersRequest.h"

@interface LoginManager()
@property (copy, nonatomic) LoginCompletionBlock completionBlock;
@end

@implementation LoginManager

- (BOOL)shouldAutoLogin {
    if ([DataManager shared].loggedInUser) {
        return YES;
    }
    return NO;
}

- (void)loginUserWithEmail:(NSString *)email 
                  password:(NSString *)password
           completionBlock:(LoginCompletionBlock)completionBlock {
    self.completionBlock = completionBlock;
    [self runLoginRequestWithEmail:email password:password];
}

- (void)performAutoLoginWithCompletionBlock:(LoginCompletionBlock)completionBlock {
    self.completionBlock = completionBlock;
    [self runLoginRequestWithEmail:[DataManager shared].loggedInUser.email
                          password:[DataManager shared].loggedInUser.password];
}

- (void)logoutUser {
    NSArray *printers = [DataManager shared].printers; // not deleting printers settings

    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [DataManager shared].printers = printers;
}

#pragma mark - Requests

- (void)runLoginRequestWithEmail:(NSString *)email password:(NSString *)password {
    LoginRequest *request = [LoginRequest requestWithEmail:email
                                                  password:password];
    request.hasCustomDisplayErrorMessage = YES;
    
    [request setSuccess:^(id request, User *user) {
        [self runRegistersRequest];
    }];
    
    [request setError:^(id request, NSError *error) {
        if (self.completionBlock) {
            self.completionBlock(NO, @"Invalid credentials.");
        }
    }];
    
    [request runRequest];
}

- (void)runRegistersRequest {
    GetRegistersRequest *request = [GetRegistersRequest request];
    request.hasCustomDisplayErrorMessage = YES;

    [request setSuccess:^(id request, id response) {
        if (self.completionBlock) {
            self.completionBlock(YES, nil);
        }
    }];
    
    [request setError:^(id request, NSError *error) {
        if (self.completionBlock) {
            self.completionBlock(NO, @"Error getting registers.");
        }
    }];
    
    [request runRequest];
}

@end

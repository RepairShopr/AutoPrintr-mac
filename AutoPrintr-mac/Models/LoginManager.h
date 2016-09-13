//
//  LoginManager.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 13/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoginCompletionBlock)(BOOL succeed, NSString *errorMessage);

@interface LoginManager : NSObject

- (BOOL)shouldAutoLogin;
- (void)loginUserWithEmail:(NSString *)email
                  password:(NSString *)password
           completionBlock:(LoginCompletionBlock)completionBlock;
- (void)performAutoLoginWithCompletionBlock:(LoginCompletionBlock)completionBlock;
- (void)logoutUser;

@end

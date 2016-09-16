//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
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

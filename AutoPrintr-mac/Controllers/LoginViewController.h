//
//  LoginViewController.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 29/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoginManager.h"

@protocol LoginDelegate <NSObject>
- (void)loginDidSucceed;
@end

@interface LoginViewController : NSViewController

+ (instancetype)createLoginManager:(LoginManager *)loginManager delegate:(id<LoginDelegate>)delegate;

@end

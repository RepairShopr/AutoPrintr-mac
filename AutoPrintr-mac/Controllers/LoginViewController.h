//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoginManager.h"

@protocol LoginDelegate <NSObject>
- (void)loginDidSucceed;
@end

@interface LoginViewController : NSViewController

+ (instancetype)createLoginManager:(LoginManager *)loginManager delegate:(id<LoginDelegate>)delegate;

@end

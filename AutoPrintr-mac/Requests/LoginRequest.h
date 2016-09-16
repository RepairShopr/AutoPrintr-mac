//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

+ (instancetype)requestWithEmail:(NSString *)email password:(NSString *)password;

@end

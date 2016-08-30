//
//  LoginRequest.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 30/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

+ (instancetype)requestWithEmail:(NSString *)email password:(NSString *)password;

@end

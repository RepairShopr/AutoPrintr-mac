//
//  User.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 31/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "User.h"
#import "Location.h"

@implementation User

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary {
    User *user = [self new];
    
    user.admin = dictionary[@"admin"];
    user.canUseApp = dictionary[@"can_use_app"];
    user.defaultLocation = dictionary[@"default_location"];
    user.enableMultiLocations = dictionary[@"enable_multi_locations"];
    user.permissions = dictionary[@"permissions"]; // TO BE HANDLE
    user.subdomain = dictionary[@"subdomain"];
    user.twoFactorRequired = dictionary[@"two_factor_required"];
    user.email = dictionary[@"user_email"];
    user.userId = dictionary[@"user_id"];
    user.name = dictionary[@"user_name"];
    user.token = dictionary[@"user_token"];
    
    NSMutableArray *locations = [NSMutableArray array];
    for (NSDictionary *dict in dictionary[@"locations_allowed"]) {
        [locations addObject:[Location createFromDictionary:dict]];
    }
    user.locations = locations;
    
    return user;
}

@end

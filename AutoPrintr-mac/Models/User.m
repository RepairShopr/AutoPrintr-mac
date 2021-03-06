//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
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

#pragma mark - NSCoding Protocol

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.email = [coder decodeObjectForKey:@"email"];
        self.password = [coder decodeObjectForKey:@"password"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.password forKey:@"password"];
}

@end

//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "Register.h"

@implementation Register

#pragma mark - Constructor

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary {
    Register *instance = [self new];
    
    instance.registerId = dictionary[@"id"];
    instance.locationId = dictionary[@"location_id"];
    instance.locationName = dictionary[@"location_name"];
    instance.name = dictionary[@"name"];
    
    return instance;
}

@end

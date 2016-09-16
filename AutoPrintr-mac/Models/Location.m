//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "Location.h"

@implementation Location

+ (instancetype)createWithId:(NSNumber *)locationId name:(NSString *)name {
    Location *location = [self new];
    
    location.locationId = locationId;
    location.name = name;
    
    return location;
}

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary {
    return [self createWithId:dictionary[@"id"] name:dictionary[@"name"]];
}

#pragma mark - NSCoding Protocol

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.locationId = [coder decodeObjectForKey:@"locationId"];
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.locationId forKey:@"locationId"];
    [coder encodeObject:self.name forKey:@"name"];
}

@end

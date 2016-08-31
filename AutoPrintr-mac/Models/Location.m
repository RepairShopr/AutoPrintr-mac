//
//  Location.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 31/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
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

@end

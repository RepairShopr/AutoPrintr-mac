//
//  Location.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 31/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *locationId;
@property (strong, nonatomic) NSString *name;

+ (instancetype)createWithId:(NSNumber *)locationId
                        name:(NSString *)name;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;

@end

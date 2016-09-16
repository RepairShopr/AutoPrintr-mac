//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *locationId;
@property (strong, nonatomic) NSString *name;

+ (instancetype)createWithId:(NSNumber *)locationId
                        name:(NSString *)name;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;

@end

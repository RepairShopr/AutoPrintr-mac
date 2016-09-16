//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Register : NSObject

@property (strong, nonatomic) NSNumber *registerId;
@property (strong, nonatomic) NSNumber *locationId;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSString *name;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;

@end

//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "User.h"

@interface DataManager : NSObject

@property (strong, nonatomic) Location *selectedLocation;
@property (strong, nonatomic) NSString *messagingChannel;
@property (strong, nonatomic) NSArray *registers;
@property (strong, nonatomic) NSArray *printers;

+ (instancetype)shared;

- (User *)loggedInUser;
- (void)setUser:(User *)user;
- (NSArray *)printersWithRegisterId:(NSNumber *)registerId;

@end

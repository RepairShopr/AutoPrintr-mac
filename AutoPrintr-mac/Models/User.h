//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *admin;
@property (strong, nonatomic) NSNumber *canUseApp;
@property (strong, nonatomic) NSNumber *defaultLocation;
@property (strong, nonatomic) NSNumber *enableMultiLocations;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) NSString *subdomain;
@property (strong, nonatomic) NSNumber *twoFactorRequired;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *token;

#warning To be handle
@property (strong, nonatomic) NSArray *permissions;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;

@end

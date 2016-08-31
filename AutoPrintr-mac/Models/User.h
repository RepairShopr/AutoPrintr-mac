//
//  User.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 31/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSNumber *admin;
@property (strong, nonatomic) NSNumber *canUseApp;
@property (strong, nonatomic) NSNumber *defaultLocation;
@property (strong, nonatomic) NSNumber *enableMultiLocations;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) NSString *subdomain;
@property (strong, nonatomic) NSNumber *twoFactorRequired;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *token;

#warning To be handle
@property (strong, nonatomic) NSArray *permissions;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;

@end

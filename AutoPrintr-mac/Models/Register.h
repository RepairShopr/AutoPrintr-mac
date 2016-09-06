//
//  Register.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 06/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Register : NSObject

@property (strong, nonatomic) NSNumber *registerId;
@property (strong, nonatomic) NSNumber *locationId;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSString *name;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;

@end

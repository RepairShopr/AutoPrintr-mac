//
//  GetRegistersRequest.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 06/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "GetRegistersRequest.h"
#import "PusherManager.h"
#import "DataManager.h"
#import "Register.h"

@implementation GetRegistersRequest

- (RequestMethod)requestMethod {
    return kRequestMethodGET;
}

- (NSString *)serverBase {
    return [NSString stringWithFormat:@"http://%@.%@", [[DataManager shared] loggedInUser].subdomain, GLOBAL_URL];
}

- (NSString *)requestURL {
    return @"/settings/printing";
}

- (NSDictionary *)params {
    return @{@"api_key": [[DataManager shared] loggedInUser].token};
}

- (id)successData:(id)data {
    [DataManager shared].messagingChannel = data[@"messaging_channel"];
    [[PusherManager shared] startListening];
    
    NSMutableArray *registers = [NSMutableArray array];
    for (NSDictionary *registerDict in data[@"registers"]) {
        Register *cashRegister = [Register createFromDictionary:registerDict];
        [registers addObject:cashRegister];
    }
    [DataManager shared].registers = registers;
    
    return registers;
}

@end

//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
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

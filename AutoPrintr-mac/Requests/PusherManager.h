//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PusherManager : NSObject

+ (instancetype)shared;

- (void)initializeReachability;
- (void)startListening;

@end

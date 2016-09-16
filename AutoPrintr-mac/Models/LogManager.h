//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject

- (void)logMessage:(NSString *)message;
- (void)openLogFile;

@end

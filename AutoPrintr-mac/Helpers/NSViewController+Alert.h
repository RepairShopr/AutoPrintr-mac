//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void (^AlertCompletionBlock)(void);

@interface NSViewController (Alert)

- (void)showAlertWithMessage:(NSString *)message;
- (void)showAlertWithMessage:(NSString *)message details:(NSString *)details;
- (void)showAlertWithMessage:(NSString *)message details:(NSString *)details completionBlock:(AlertCompletionBlock)completionBlock;

@end

//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "NSViewController+Alert.h"

@implementation NSViewController (Alert)

- (void)showAlertWithMessage:(NSString *)message {
    [self showAlertWithMessage:message details:@""];
}

- (void)showAlertWithMessage:(NSString *)message details:(NSString *)details {
    [self showAlertWithMessage:message details:details completionBlock:nil];
}

- (void)showAlertWithMessage:(NSString *)message details:(NSString *)details completionBlock:(AlertCompletionBlock)completionBlock {
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:message];
    [alert setInformativeText:details];
    [alert setAlertStyle:NSCriticalAlertStyle];
    
    [alert beginSheetModalForWindow:self.view.window
                  completionHandler:^(NSModalResponse returnCode) {
                      if (completionBlock) {
                          completionBlock();
                      }
                  }];
}

@end

//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "AlertViewManager.h"
#import <Cocoa/Cocoa.h>

@implementation AlertViewManager

+ (AlertViewManager *)shared {
    static AlertViewManager *manager;
    if (manager == nil) {
        manager = [AlertViewManager new];
    }
    return manager;
}

- (void)showAlertWithMessage:(NSString *)message {
    [self showAlertWithMessage:message andDetails:@""];
}

- (void)showAlertWithMessage:(NSString *)message andDetails:(NSString *)details {
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:message];
    [alert setInformativeText:details];
    [alert setAlertStyle:NSCriticalAlertStyle];
    
    [alert beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] completionHandler:^(NSModalResponse returnCode) {
        [self dissmissAlert];
    }];
}

- (BOOL)isShowingAlert {
    return ([[NSApplication sharedApplication] mainWindow].attachedSheet != nil);
}

- (void)dissmissAlert {
    [[[NSApplication sharedApplication] mainWindow] endSheet:[[NSApplication sharedApplication] mainWindow].attachedSheet];
}

@end

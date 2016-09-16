//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertViewManager : NSObject

+ (AlertViewManager *)shared;

- (void)showAlertWithMessage:(NSString *)message;
- (void)showAlertWithMessage:(NSString *)message andDetails:(NSString *)details;
- (BOOL)isShowingAlert;
- (void)dissmissAlert;

@end

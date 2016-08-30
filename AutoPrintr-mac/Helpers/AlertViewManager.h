//
//  AlertViewManager.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 30/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertViewManager : NSObject

+ (AlertViewManager *)shared;

- (void)showAlertWithMessage:(NSString *)message;
- (void)showAlertWithMessage:(NSString *)message andDetails:(NSString *)details;
- (BOOL)isShowingAlert;
- (void)dissmissAlert;

@end

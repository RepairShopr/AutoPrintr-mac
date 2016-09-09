//
//  PusherManager.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 09/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PusherManager : NSObject

+ (instancetype)shared;

- (void)startListening;

@end

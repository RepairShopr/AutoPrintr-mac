//
//  DataManager.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 31/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DataManager : NSObject

+ (instancetype)shared;

@property (strong, nonatomic) User *loggedInUser;

@end

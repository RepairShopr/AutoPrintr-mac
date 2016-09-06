//
//  DataManager.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 31/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "DataManager.h"
#import "Printer.h"

static NSString * const printersKey = @"printersKey";
static NSString * const loggedInUserKey = @"loggedInUserKey";

@interface DataManager()
@property (strong, nonatomic) User *loggedInUser;
@end

@implementation DataManager

#pragma mark - Singleton

+ (instancetype)shared {
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DataManager new];
    });
    
    return sharedInstance;
}

#pragma mark - Printers

- (NSArray *)printers {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedPrintersData = [defaults objectForKey:printersKey];
    
    if (savedPrintersData == nil) {
        // save to defaults
        NSArray *printersArray = [Printer allAvailablePrinters];
        
        savedPrintersData = [NSKeyedArchiver archivedDataWithRootObject:printersArray];
        [defaults setObject:savedPrintersData forKey:printersKey];
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:savedPrintersData];
}

- (void)setPrinters:(NSArray *)printers {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedPrintersData = [NSKeyedArchiver archivedDataWithRootObject:printers];
    [defaults setObject:savedPrintersData forKey:printersKey];
}

#pragma mark - Logged In User

- (User *)loggedInUser {
    if (_loggedInUser) {
        return _loggedInUser;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedUserData = [defaults objectForKey:loggedInUserKey];
    
    if (savedUserData == nil) {
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:savedUserData];
}

- (void)setUser:(User *)user {
    self.loggedInUser = user;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedUserData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [defaults setObject:savedUserData forKey:loggedInUserKey];
}

@end

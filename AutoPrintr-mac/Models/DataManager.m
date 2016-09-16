//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "DataManager.h"
#import "Printer.h"

static NSString * const printersKey = @"printersKey";
static NSString * const loggedInUserKey = @"loggedInUserKey";
static NSString * const selectedLocationKey = @"selectedLocationKey";

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
    NSArray *allPrinters = [Printer allAvailablePrinters];
    NSMutableArray *printers;
    
    if (savedPrintersData == nil) {
        // save to defaults
        savedPrintersData = [NSKeyedArchiver archivedDataWithRootObject:allPrinters];
        [defaults setObject:savedPrintersData forKey:printersKey];
    } else {
        printers = [NSKeyedUnarchiver unarchiveObjectWithData:savedPrintersData];
        for (Printer *printer in allPrinters) {
            BOOL found = NO;
            for (Printer *savedPrinter in printers) {
                if ([printer.name isEqualToString:savedPrinter.name]) {
                    found = YES;
                    break;
                }
            }
            
            if (!found) {
                [printers addObject:printer];
            }
        }
        
        // save to defaults
        savedPrintersData = [NSKeyedArchiver archivedDataWithRootObject:printers];
        [defaults setObject:savedPrintersData forKey:printersKey];
    }
    
    printers = [NSKeyedUnarchiver unarchiveObjectWithData:savedPrintersData];
    return printers;
}

- (void)setPrinters:(NSArray *)printers {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedPrintersData = [NSKeyedArchiver archivedDataWithRootObject:printers];
    [defaults setObject:savedPrintersData forKey:printersKey];
}

- (NSArray *)printersWithRegisterId:(NSNumber *)registerId {
    NSMutableArray *printers = [NSMutableArray array];
    
    if ([registerId isKindOfClass:[NSNull class]]) {
        printers = [NSMutableArray arrayWithArray:self.printers];
    } else {
        NSArray *allPrinters = self.printers;
        for (Printer *printer in allPrinters) {
            NSNumber *printerRegisterId;
            if (printer.registerId && ! [printer.registerId isEqualToString:@"None"]) {
                printerRegisterId = @([printer.registerId integerValue]);
            }
            if ([printerRegisterId isEqualToNumber:registerId]) {
                [printers addObject:printer];
            }
        }
    }
    
    return printers;
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

#pragma mark - Selected location

- (Location *)selectedLocation {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedSelectedLocationData = [defaults objectForKey:selectedLocationKey];
    
    if (savedSelectedLocationData == nil) {
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:savedSelectedLocationData];
}

- (void)setSelectedLocation:(Location *)selectedLocation {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedSelectedLocationData = [NSKeyedArchiver archivedDataWithRootObject:selectedLocation];
    [defaults setObject:savedSelectedLocationData forKey:selectedLocationKey];
}

@end

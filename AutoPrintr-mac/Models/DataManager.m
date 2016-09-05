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

@interface DataManager()
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

#pragma mark - Documents Settings

- (NSArray *)documentsSettingsForPrinterWithName:(NSString *)printerName {
    for (Printer *printer in self.printers) {
        if ([printer.name isEqualToString:printerName]) {
            return printer.documentsSettings;
        }
    }
    
    return nil;
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


@end

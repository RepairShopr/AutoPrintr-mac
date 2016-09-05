//
//  Printer.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 05/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "Printer.h"
#import "DataManager.h"
#import "DocumentSettings.h"

@implementation Printer 

#pragma mark - Constructor 

+ (instancetype)createWithName:(NSString *)name documentsSettings:(NSArray *)documentsSettings {
    Printer *printer = [self new];
    
    printer.name = name;
    printer.documentsSettings = documentsSettings;
    
    return printer;
}

#pragma mark - All Printers

+ (NSArray *)allAvailablePrinters {
    NSTask *task = [NSTask new];
    NSPipe *pipe = [NSPipe new];
    NSFileHandle *file = pipe.fileHandleForReading;
    
    NSArray *args = @[@"-c", @"lpstat -a | awk '{print $1}'"];
    task.launchPath = @"/bin/bash";
    task.arguments = args;
    task.standardOutput = pipe;
    task.standardError = pipe;
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    [file closeFile];
    
    NSString *commandOutput = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *printersName = [commandOutput componentsSeparatedByString:@"\n"];
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *printerName in printersName) {
        if (printerName.length) {
            [result addObject:[self createWithName:printerName
                                 documentsSettings:[DocumentSettings defaultSettings]]];
        }
    }
    
    return result;
}

#pragma mark - NSCoding Protocol

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.documentsSettings = [aDecoder decodeObjectForKey:@"documentsSettings"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.documentsSettings forKey:@"documentsSettings"];
}

@end

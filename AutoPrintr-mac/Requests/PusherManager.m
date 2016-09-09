//
//  PusherManager.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 09/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "PusherManager.h"
#import <Pusher/Pusher.h>
#import "AppKeys.h"
#import "PrintJob.h"
#import "DataManager.h"
#import "Printer.h"

@interface PusherManager() <PTPusherDelegate>
@property (strong, nonatomic) PTPusher *client;
@end

@implementation PusherManager

#pragma mark - Singleton

+ (instancetype)shared {
    static PusherManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PusherManager new];
    });
    
    return sharedInstance;
}

- (void)startListening {
    self.client = [PTPusher pusherWithKey:Pusher_KEY delegate:self encrypted:YES];
    
    PTPusherChannel *channel = [self.client subscribeToChannelNamed:@"test_channel"];
    
    [channel bindToEventNamed:@"my_event" handleWithBlock:^(PTPusherEvent *channelEvent) {
        PrintJob *printJob = [PrintJob createFromDictionary:channelEvent.data];
        [self handlePrintJob:printJob];
    }];
    
    [self.client connect];
}

- (void)handlePrintJob:(PrintJob *)printJob {
    // check job location
    if (! [printJob.locationId isEqualToNumber:[DataManager shared].selectedLocation.locationId]) {
        return;
    }
    
    NSArray *printers = [self printersWithRegisterId:printJob.registerId];
    for (Printer *printer in printers) {
        DocumentSettings *printerDocumentSettings;
        for (DocumentSettings *settings in printer.documentsSettings) {
            if (settings.documentType == printJob.documentType) {
                printerDocumentSettings = settings;
                break;
            }
        }
        
        if (! printerDocumentSettings.enabled) {
            continue;
        }
        
        if (printerDocumentSettings.autoPrintFromTriggers || printJob.autoprinted == NO) {
            [self executePrintJob:printJob toPrinter:printer quantity:printerDocumentSettings.quantity];
        }
    }
}

- (NSArray *)printersWithRegisterId:(NSNumber *)registerId {
    NSMutableArray *printers = [NSMutableArray array];
    
    if ([registerId isKindOfClass:[NSNull class]]) {
        printers = [NSMutableArray arrayWithArray:[DataManager shared].printers];
    } else {
        NSArray *allPrinters = [DataManager shared].printers;
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

- (void)executePrintJob:(PrintJob *)printJob
              toPrinter:(Printer *)printer
               quantity:(NSInteger)quantity {
    
    NSURL *url = [NSURL URLWithString:printJob.fileURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"filename.pdf"];
    [urlData writeToFile:filePath atomically:YES];
    
    NSTask *task = [NSTask new];
    NSPipe *pipe = [NSPipe new];
    NSFileHandle *file = pipe.fileHandleForReading;
    
    NSArray *args = @[@"-l", @"-c", [NSString stringWithFormat:@"lp -d %@ -n %zd %@", printer.name, quantity, filePath]];
    task.launchPath = @"/bin/bash";
    task.arguments = args;
    task.standardOutput = pipe;
    task.standardError = pipe;
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    [file closeFile];
    
    NSString *commandOutput = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", commandOutput);
}


@end

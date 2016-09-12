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

static NSString * const kPusherChannel = @"test_channel";
static NSString * const kPusherEvent = @"my_event";

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

#pragma mark - Channel Listening

- (void)startListening {
    self.client = [PTPusher pusherWithKey:Pusher_KEY delegate:self encrypted:YES];
    
    PTPusherChannel *channel = [self.client subscribeToChannelNamed:kPusherChannel];
    
    [channel bindToEventNamed:kPusherEvent handleWithBlock:^(PTPusherEvent *channelEvent) {
        PrintJob *printJob = [PrintJob createFromDictionary:channelEvent.data];
        [self handlePrintJob:printJob];
    }];
    
    [self.client connect];
}

#pragma mark - Print Jobs Handling

- (void)handlePrintJob:(PrintJob *)printJob {
    // check job location
    if (! [printJob.locationId isEqualToNumber:[DataManager shared].selectedLocation.locationId]) {
        return;
    }
    
    NSArray *printers = [[DataManager shared] printersWithRegisterId:printJob.registerId];
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

#pragma mark - Print the file

- (void)executePrintJob:(PrintJob *)printJob
              toPrinter:(Printer *)printer
               quantity:(NSInteger)quantity {
    
    NSURL *url = [NSURL URLWithString:printJob.fileURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"JOB_%zd.pdf", [NSDate timeIntervalSinceReferenceDate]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
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

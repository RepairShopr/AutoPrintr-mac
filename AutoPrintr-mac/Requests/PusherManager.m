//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "PusherManager.h"
#import <Reachability/Reachability.h>
#import <Pusher/Pusher.h>
#import "AppKeys.h"
#import "PrintJob.h"
#import "DataManager.h"
#import "LogManager.h"
#import "Printer.h"

static NSString * const kPusherEvent = @"print-job";
static NSString * const kTestingHostname = @"www.google.com";

@interface PusherManager() <PTPusherDelegate>
@property (strong, nonatomic) PTPusher *client;
@property (strong, nonatomic) LogManager *logManager;
@end

@implementation PusherManager

#pragma mark - Singleton

+ (instancetype)shared {
    static PusherManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PusherManager new];
        sharedInstance.logManager = [LogManager new];
    });
    
    return sharedInstance;
}

#pragma mark - Reachability

- (void)initializeReachability {
    Reachability *reach = [Reachability reachabilityWithHostname:kTestingHostname];
    
    __weak typeof(self) _weakSelf = self;
    reach.reachableBlock = ^(Reachability *reach) {
        [_weakSelf.client connect];
    };
    
    [reach startNotifier];
}

#pragma mark - Channel Listening

- (void)startListening {
    self.client = [PTPusher pusherWithKey:Pusher_KEY delegate:self encrypted:YES];
    
    PTPusherChannel *channel = [self.client subscribeToChannelNamed:[DataManager shared].messagingChannel];
    
    [channel bindToEventNamed:kPusherEvent handleWithBlock:^(PTPusherEvent *channelEvent) {
        PrintJob *printJob = [PrintJob createFromDictionary:channelEvent.data];
        [self.logManager logMessage:[NSString stringWithFormat:@"Event received: %@", printJob.description]];
        
        [self handlePrintJob:printJob];
    }];
    
    [self.client connect];
}

#pragma mark - Print Jobs Handling

- (void)handlePrintJob:(PrintJob *)printJob {
    // check job location
    if (![printJob.locationId isKindOfClass:[NSNull class]] && ![printJob.locationId isEqualToNumber:[DataManager shared].selectedLocation.locationId]) {
        NSString *message = [NSString stringWithFormat:@"Print skipped - printJob location %@ - your location: %@",
                             printJob.locationId,
                             [DataManager shared].selectedLocation.locationId];
        [self.logManager logMessage:message];
        return;
    }
    
    NSArray *printers = [[DataManager shared] printersWithRegisterId:printJob.registerId];
    BOOL foundPrinter = NO;
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
            NSString *message = [NSString stringWithFormat:@"Sending \"%@\" print to printer %@", printJob.document, printer.name];
            [self.logManager logMessage:message];
            
            foundPrinter = YES;
            [self executePrintJob:printJob toPrinter:printer quantity:printerDocumentSettings.quantity];
        }
    }
    
    if (! foundPrinter) {
        NSString *message = [NSString stringWithFormat:@"Print skipped - you have no printers for job type %@", printJob.document];
        [self.logManager logMessage:message];
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
    
    NSInteger timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *fileName = [NSString stringWithFormat:@"JOB_%zd.pdf", timestamp];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    [urlData writeToFile:filePath atomically:YES];
    
    NSTask *task = [NSTask new];
    NSPipe *outputPipe = [NSPipe new];
    NSFileHandle *outputFile = outputPipe.fileHandleForReading;

    NSPipe *errorPipe = [NSPipe new];
    NSFileHandle *errorFile = errorPipe.fileHandleForReading;
    
    NSArray *args = @[@"-l", @"-c", [NSString stringWithFormat:@"lp -d %@ -n %zd %@", printer.name, quantity, filePath]];
    task.launchPath = @"/bin/bash";
    task.arguments = args;
    task.standardOutput = outputPipe;
    task.standardError = errorPipe;
    [task launch];
    
    NSData *outputData = [outputFile readDataToEndOfFile];
    [outputFile closeFile];
    NSString *commandOutput = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];

    NSData *errorData = [errorFile readDataToEndOfFile];
    [errorFile closeFile];
    NSString *errorOutput = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];

    if (commandOutput.length) {
        [self.logManager logMessage:@"Printer received job"];
    } else {
        [self.logManager logMessage:[NSString stringWithFormat:@"Print failed: - %@", errorOutput]];
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

#pragma mark - PTPusherDelegate

- (BOOL)pusher:(PTPusher *)pusher connectionWillAutomaticallyReconnect:(PTPusherConnection *)connection afterDelay:(NSTimeInterval)delay {
    return YES;
}

@end

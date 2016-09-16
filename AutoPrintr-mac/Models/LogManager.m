//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "LogManager.h"
#import "NSFileManager+DirectoryLocations.h"

static NSInteger const maximumNumberOfReports = 1000;
static NSInteger const numberOfLinesInReport = 3;
static NSInteger const maximumNumberOfLines = maximumNumberOfReports * numberOfLinesInReport;

@implementation LogManager

- (void)logMessage:(NSString *)message {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterMediumStyle];
    message = [NSString stringWithFormat:@"%@\n%@\n\n", dateString, message];
    
    NSString *path = [[NSFileManager defaultManager] applicationSupportDirectory];
    NSString *logFilePath = [path stringByAppendingPathComponent:@"log.txt"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [message writeToFile:logFilePath
                  atomically:YES
                    encoding:NSUTF8StringEncoding
                       error:nil];
    } else {
        NSString *stringFromFile = [[NSString alloc] initWithContentsOfFile:logFilePath
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
        NSArray *currentLines = [stringFromFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        if (currentLines.count >= maximumNumberOfLines) {
            NSMutableArray *lines = [NSMutableArray arrayWithArray:currentLines];
            [lines removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, numberOfLinesInReport)]];
            
            NSString *fileContent = [lines componentsJoinedByString:@"\n"];
            fileContent = [fileContent stringByAppendingString:message];

            [fileContent writeToFile:logFilePath
                      atomically:YES
                        encoding:NSUTF8StringEncoding
                           error:nil];
        } else {
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }
    }
}

- (void)openLogFile {
    NSTask *task = [NSTask new];

    NSString *path = [[NSFileManager defaultManager] applicationSupportDirectory];
    NSString *logFilePath = [path stringByAppendingPathComponent:@"log.txt"];
    logFilePath = [logFilePath stringByReplacingOccurrencesOfString:@" " withString:@"\\ "];
    
    NSArray *args = @[@"-c", [NSString stringWithFormat:@"open -a TextEdit %@", logFilePath]];
    task.launchPath = @"/bin/bash";
    task.arguments = args;
    [task launch];
}

@end

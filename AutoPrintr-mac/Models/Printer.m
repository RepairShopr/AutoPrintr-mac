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

+ (instancetype)createWithName:(NSString *)name
             documentsSettings:(NSArray *)documentsSettings
                    registerId:(NSNumber *)registerId {
    Printer *printer = [self new];
    
    printer.name = name;
    printer.documentsSettings = [NSMutableArray arrayWithArray:documentsSettings];
    printer.registerId = registerId;
    
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
                                 documentsSettings:[DocumentSettings defaultSettings]
                                        registerId:nil]];
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
        self.registerId = [aDecoder decodeObjectForKey:@"registerId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.documentsSettings forKey:@"documentsSettings"];
    [aCoder encodeObject:self.registerId forKey:@"registerId"];
}

#pragma mark - Document Settings

- (DocumentSettings *)settingsLetterInvoice {
    return [self documentSettingsWithType:DocTypeLetterInvoice];
}

- (void)setSettingsLetterInvoice:(DocumentSettings *)settingsLetterInvoice {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLetterInvoice]
                                      withObject:settingsLetterInvoice];
}

- (DocumentSettings *)settingsLetterEstimate {
    return [self documentSettingsWithType:DocTypeLetterEstimate];
}

- (void)setSettingsLetterEstimate:(DocumentSettings *)settingsLetterEstimate {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLetterEstimate]
                                      withObject:settingsLetterEstimate];
}

- (DocumentSettings *)settingsLetterTicket {
    return [self documentSettingsWithType:DocTypeLetterTicket];
}

- (void)setSettingsLetterTicket:(DocumentSettings *)settingsLetterTicket {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLetterTicket]
                                      withObject:settingsLetterTicket];
}

- (DocumentSettings *)settingsLetterIntakeForm {
    return [self documentSettingsWithType:DocTypeLetterIntakeForm];
}

- (void)setSettingsLetterIntakeForm:(DocumentSettings *)settingsLetterIntakeForm {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLetterIntakeForm]
                                      withObject:settingsLetterIntakeForm];
}

- (DocumentSettings *)settingsReceiptReceipt {
    return [self documentSettingsWithType:DocTypeReceiptReceipt];
}

- (void)setSettingsReceiptReceipt:(DocumentSettings *)settingsReceiptReceipt {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeReceiptReceipt]
                                      withObject:settingsReceiptReceipt];
}

- (DocumentSettings *)settingsReceiptZReport {
    return [self documentSettingsWithType:DocTypeReceiptZReport];
}

- (void)setSettingsReceiptZReport:(DocumentSettings *)settingsReceiptZReport {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeReceiptZReport]
                                      withObject:settingsReceiptZReport];
}

- (DocumentSettings *)settingsReceiptTicketReceipt {
    return [self documentSettingsWithType:DocTypeReceiptTicketReceipt];
}

- (void)setSettingsReceiptTicketReceipt:(DocumentSettings *)settingsReceiptTicketReceipt {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeReceiptTicketReceipt]
                                      withObject:settingsReceiptTicketReceipt];
}

- (DocumentSettings *)settingsReceiptPopDrawer {
    return [self documentSettingsWithType:DocTypeReceiptPopDrawer];
}

- (void)setSettingsReceiptPopDrawer:(DocumentSettings *)settingsReceiptPopDrawer {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeReceiptPopDrawer]
                                      withObject:settingsReceiptPopDrawer];
}

- (DocumentSettings *)settingsReceiptAdjustment {
    return [self documentSettingsWithType:DocTypeReceiptAdjustment];
}

- (void)setSettingsReceiptAdjustment:(DocumentSettings *)settingsReceiptAdjustment {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeReceiptAdjustment]
                                      withObject:settingsReceiptAdjustment];
}

- (DocumentSettings *)settingsLabelCustomerID {
    return [self documentSettingsWithType:DocTypeLabelCustomerID];
}

- (void)setSettingsLabelCustomerID:(DocumentSettings *)settingsLabelCustomerID {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLabelCustomerID]
                                      withObject:settingsLabelCustomerID];
}

- (DocumentSettings *)settingsLabelAsset {
    return [self documentSettingsWithType:DocTypeLabelAsset];
}

- (void)setSettingsLabelAsset:(DocumentSettings *)settingsLabelAsset {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLabelAsset]
                                      withObject:settingsLabelAsset];
}

- (DocumentSettings *)settingsLabelTicketLabel {
    return [self documentSettingsWithType:DocTypeLabelTicketLabel];
}

- (void)setSettingsLabelTicketLabel:(DocumentSettings *)settingsLabelTicketLabel {
    [self.documentsSettings replaceObjectAtIndex:[self indexOfDocumentSettingsWithType:DocTypeLabelTicketLabel]
                                      withObject:settingsLabelTicketLabel];
}

#pragma mark - Helpers

- (DocumentSettings *)documentSettingsWithType:(DocumentType)documentType {
    for (DocumentSettings *settings in self.documentsSettings) {
        if (settings.documentType == documentType) {
            return settings;
        }
    }
    return nil;
}

- (NSInteger)indexOfDocumentSettingsWithType:(DocumentType)documentType {
    for (DocumentSettings *settings in self.documentsSettings) {
        if (settings.documentType == documentType) {
            return [self.documentsSettings indexOfObject:settings];
        }
    }
    return 0;
}

@end

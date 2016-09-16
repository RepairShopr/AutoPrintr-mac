//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "DocumentSettings.h"

@implementation DocumentSettings

#pragma mark - Constructor

+ (instancetype)createWithType:(DocumentType)documentType
                      quantity:(NSInteger)quantity
                       enabled:(BOOL)enabled
         autoPrintFromTriggers:(BOOL)autoprint {
    DocumentSettings *settings = [self new];
    
    settings.documentType = documentType;
    settings.quantity = quantity;
    settings.enabled = enabled;
    settings.autoPrintFromTriggers = autoprint;
    
    return settings;
}

+ (instancetype)createDefaultSettingsForDocumentType:(DocumentType)documentType {
    return [self createWithType:documentType
                       quantity:0
                        enabled:NO
          autoPrintFromTriggers:NO];
}

+ (NSArray *)defaultSettings {
    return @[[self createDefaultSettingsForDocumentType:DocTypeLetterInvoice],
             [self createDefaultSettingsForDocumentType:DocTypeLetterEstimate],
             [self createDefaultSettingsForDocumentType:DocTypeLetterTicket],
             [self createDefaultSettingsForDocumentType:DocTypeLetterIntakeForm],
             [self createDefaultSettingsForDocumentType:DocTypeReceiptReceipt],
             [self createDefaultSettingsForDocumentType:DocTypeReceiptZReport],
             [self createDefaultSettingsForDocumentType:DocTypeReceiptTicketReceipt],
             [self createDefaultSettingsForDocumentType:DocTypeReceiptPopDrawer],
             [self createDefaultSettingsForDocumentType:DocTypeReceiptAdjustment],
             [self createDefaultSettingsForDocumentType:DocTypeLabelCustomerID],
             [self createDefaultSettingsForDocumentType:DocTypeLabelAsset],
             [self createDefaultSettingsForDocumentType:DocTypeLabelTicketLabel]];
}

#pragma mark - NSCoding Protocol

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        self.documentType = [[aDecoder decodeObjectForKey:@"documentType"] unsignedIntegerValue];
        self.quantity = [[aDecoder decodeObjectForKey:@"quantity"] integerValue];
        self.enabled = [[aDecoder decodeObjectForKey:@"enabled"] boolValue];
        self.autoPrintFromTriggers = [[aDecoder decodeObjectForKey:@"autoPrintFromTriggers"] boolValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.documentType) forKey:@"documentType"];
    [aCoder encodeObject:@(self.quantity) forKey:@"quantity"];
    [aCoder encodeObject:@(self.enabled) forKey:@"enabled"];
    [aCoder encodeObject:@(self.autoPrintFromTriggers) forKey:@"autoPrintFromTriggers"];
}

@end

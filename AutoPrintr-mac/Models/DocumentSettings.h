//
//  DocumentType.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 05/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DocumentType) {
    DocTypeLetterInvoice,
    DocTypeLetterEstimate,
    DocTypeLetterTicket,
    DocTypeLetterIntakeForm,
    DocTypeReceiptReceipt,
    DocTypeReceiptZReport,
    DocTypeReceiptTicketReceipt,
    DocTypeReceiptPopDrawer,
    DocTypeReceiptAdjustment,
    DocTypeLabelCustomerID,
    DocTypeLabelAsset,
    DocTypeLabelTicketLabel
};

@interface DocumentSettings : NSObject <NSCoding>

@property (nonatomic) DocumentType documentType;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL autoPrintFromTriggers;

+ (instancetype)createDefaultSettingsForDocumentType:(DocumentType)documentType;

+ (instancetype)createWithType:(DocumentType)documentType
                      quantity:(NSInteger)quantity
                       enabled:(BOOL)enabled
         autoPrintFromTriggers:(BOOL)autoprint;

+ (NSArray *)defaultSettings;

@end

//
//  Printer.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 05/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DocumentSettings.h"

@interface Printer : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *documentsSettings;

+ (instancetype)createWithName:(NSString *)name
             documentsSettings:(NSArray *)documentsSettings;
+ (NSArray *)allAvailablePrinters;

@property (strong, nonatomic) DocumentSettings *settingsLetterInvoice;
@property (strong, nonatomic) DocumentSettings *settingsLetterEstimate;
@property (strong, nonatomic) DocumentSettings *settingsLetterTicket;
@property (strong, nonatomic) DocumentSettings *settingsLetterIntakeForm;

#warning to be handle
@property (strong, nonatomic) DocumentSettings *settingsReceiptReceipt;
@property (strong, nonatomic) DocumentSettings *settingsReceiptZReport;
@property (strong, nonatomic) DocumentSettings *settingsReceiptTicketReceipt;
@property (strong, nonatomic) DocumentSettings *settingsReceiptPopDrawer;
@property (strong, nonatomic) DocumentSettings *settingsReceiptAdjustment;
@property (strong, nonatomic) DocumentSettings *settingsLabelCustomerID;
@property (strong, nonatomic) DocumentSettings *settingsLabelAsset;
@property (strong, nonatomic) DocumentSettings *settingsLabelTicketLabel;

@end

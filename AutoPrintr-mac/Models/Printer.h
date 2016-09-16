//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DocumentSettings.h"

@interface Printer : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *registerId;
@property (strong, nonatomic) NSMutableArray *documentsSettings;

@property (strong, nonatomic) DocumentSettings *settingsLetterInvoice;
@property (strong, nonatomic) DocumentSettings *settingsLetterEstimate;
@property (strong, nonatomic) DocumentSettings *settingsLetterTicket;
@property (strong, nonatomic) DocumentSettings *settingsLetterIntakeForm;
@property (strong, nonatomic) DocumentSettings *settingsReceiptReceipt;
@property (strong, nonatomic) DocumentSettings *settingsReceiptZReport;
@property (strong, nonatomic) DocumentSettings *settingsReceiptTicketReceipt;
@property (strong, nonatomic) DocumentSettings *settingsReceiptPopDrawer;
@property (strong, nonatomic) DocumentSettings *settingsReceiptAdjustment;
@property (strong, nonatomic) DocumentSettings *settingsLabelCustomerID;
@property (strong, nonatomic) DocumentSettings *settingsLabelAsset;
@property (strong, nonatomic) DocumentSettings *settingsLabelTicketLabel;

+ (instancetype)createWithName:(NSString *)name
             documentsSettings:(NSArray *)documentsSettings
                    registerId:(NSNumber *)registerId;
+ (NSArray *)allAvailablePrinters;

@end

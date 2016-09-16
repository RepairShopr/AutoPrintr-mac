//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "PrintJob.h"

@implementation PrintJob

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary {
    PrintJob *job = [self new];
    
    job.document = dictionary[@"document"];
    job.autoprinted = [dictionary[@"autoprinted"] boolValue];
    job.registerId = dictionary[@"register"];
    job.documentTypeName = dictionary[@"type"];
    job.fileURL = dictionary[@"file"];
    job.locationId = dictionary[@"location"];
    
    return job;
}

- (DocumentType)documentType {
    NSDictionary *documentsTypes = @{
                                     @"Invoice": @(DocTypeLetterInvoice),
                                     @"Estimate": @(DocTypeLetterEstimate),
                                     @"Ticket": @(DocTypeLetterTicket),
                                     @"IntakeForm": @(DocTypeLetterIntakeForm),
                                     @"Receipt": @(DocTypeReceiptReceipt),
                                     @"ZReport": @(DocTypeReceiptZReport),
                                     @"TicketReceipt": @(DocTypeReceiptTicketReceipt),
                                     @"PopDrawer": @(DocTypeReceiptPopDrawer),
                                     @"Adjustment": @(DocTypeReceiptAdjustment),
                                     @"CustomerID": @(DocTypeLabelCustomerID),
                                     @"Asset": @(DocTypeLabelAsset),
                                     @"TicketLabel": @(DocTypeLabelTicketLabel)};
    
    return [documentsTypes[self.document] integerValue];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Job: Document: %@; Document Type: %@; RegisterID: %@; LocationID: %@",
            self.document,
            self.documentTypeName,
            self.registerId,
            self.locationId];
}

@end

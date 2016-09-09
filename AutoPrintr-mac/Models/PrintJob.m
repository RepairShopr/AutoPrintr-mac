//
//  PrintJob.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 09/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
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
#warning handle this!!!
#warning handle this!!!
#warning handle this!!!
#warning handle this!!!
#warning handle this!!!
    return DocTypeLabelCustomerID;
}

@end

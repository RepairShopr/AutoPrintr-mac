//
//  PrintJob.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 09/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DocumentSettings.h"

@interface PrintJob : NSObject

@property (strong, nonatomic) NSString *document;
@property (strong, nonatomic) NSString *documentTypeName;
@property (strong, nonatomic) NSNumber *registerId;
@property (strong, nonatomic) NSNumber *locationId;
@property (strong, nonatomic) NSString *fileURL;

@property (nonatomic) BOOL autoprinted;

+ (instancetype)createFromDictionary:(NSDictionary *)dictionary;
- (DocumentType)documentType;

@end

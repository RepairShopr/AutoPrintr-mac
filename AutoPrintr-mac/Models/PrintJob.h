//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
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

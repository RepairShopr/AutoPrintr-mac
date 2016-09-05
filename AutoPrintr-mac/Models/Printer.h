//
//  Printer.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 05/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Printer : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *documentsSettings;

+ (instancetype)createWithName:(NSString *)name
             documentsSettings:(NSArray *)documentsSettings;
+ (NSArray *)allAvailablePrinters;

@end

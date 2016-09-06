//
//  PrintersController.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 06/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "PrintersController.h"
#import "DataManager.h"
#import "Printer.h"

@implementation PrintersController

- (void)awakeFromNib {
    self.printers = [NSMutableArray array];
    [self.printersController addObjects:[DataManager shared].printers];
}

@end

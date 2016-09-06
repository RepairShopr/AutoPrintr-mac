//
//  PrintersController.h
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 06/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface PrintersController : NSObject

@property (strong) IBOutlet NSArrayController *printersController;
@property (strong, nonatomic) NSMutableArray *printers;

@end

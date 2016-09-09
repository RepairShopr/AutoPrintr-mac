//
//  SettingsViewController.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 01/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "SettingsViewController.h"
#import "DataManager.h"
#import "Printer.h"
#import "Register.h"

@interface SettingsViewController ()
@property (strong) IBOutlet NSArrayController *printersController;
@property (strong) IBOutlet NSArrayController *registersController;

@property (strong, nonatomic) NSMutableArray *registersIds;
@property (strong, nonatomic) NSMutableArray *printers;
@end

@implementation SettingsViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.printers = [NSMutableArray array];
    [self.printersController addObjects:[DataManager shared].printers];
    
    self.registersIds = [NSMutableArray array];
    
    NSArray *registers = [DataManager shared].registers;
    [self.registersController addObject:@"None"];
    for (Register *cashRegister in registers) {
        [self.registersController addObject:[cashRegister.registerId stringValue]];
    }
}

#pragma mark - Buttons Actions

- (IBAction)didTapSaveButton:(id)sender {
    [DataManager shared].printers = self.printers;
    [self.view.window performClose:self];
}

@end

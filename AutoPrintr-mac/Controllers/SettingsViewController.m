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

@interface SettingsViewController ()
@property (weak) IBOutlet NSCollectionView *collectionView;
@property (strong) IBOutlet NSArrayController *printersController;

@property (strong, nonatomic) NSMutableArray *printers;
@end

@implementation SettingsViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.printers = [NSMutableArray array];
    [self.printersController addObjects:[DataManager shared].printers];
}

#pragma mark - Buttons Actions

- (IBAction)didTapSaveButton:(id)sender {
    [DataManager shared].printers = self.printers;
}

@end

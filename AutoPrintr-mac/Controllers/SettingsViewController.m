//
//  SettingsViewController.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 01/09/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "SettingsViewController.h"
#import "DataManager.h"

@interface SettingsViewController ()
@property (weak) IBOutlet NSButton *ticketsButton;
@property (weak) IBOutlet NSButton *ticketReceiptsButton;
@property (weak) IBOutlet NSButton *intakeFormsButton;
@property (weak) IBOutlet NSButton *invoicesButton;
@property (weak) IBOutlet NSButton *receiptsButton;
@property (weak) IBOutlet NSButton *customerLabelsButton;
@property (weak) IBOutlet NSButton *assetLabelsButton;
@property (weak) IBOutlet NSButton *ticketLabelsButton;

@property (weak) IBOutlet NSCollectionView *collectionView;
@end

@implementation SettingsViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Buttons Actions

- (IBAction)didTapSaveButton:(id)sender {
}

@end

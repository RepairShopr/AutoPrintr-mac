//
//  SelectLocationViewController.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 30/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "SelectLocationViewController.h"
#import "SettingsViewController.h"
#import "PresentationAnimator.h"
#import "LoginViewController.h"
#import "DataManager.h"

@interface SelectLocationViewController ()
@property (weak) IBOutlet NSTextField *selectedLocationLabel;
@property (weak) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *arrayController;

@property (strong, nonatomic) NSArray *locations;
@end

@implementation SelectLocationViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locations = [DataManager shared].loggedInUser.locations;
    if ([DataManager shared].selectedLocation) {
        self.selectedLocationLabel.stringValue = [DataManager shared].selectedLocation.name;
    }
    
    [self selectDefaultLocation];
}

- (void)selectDefaultLocation {
    [[self.view window] makeFirstResponder:self.tableView];
    
    NSNumber *defaultLocationId = [DataManager shared].loggedInUser.defaultLocation;
    if (defaultLocationId == nil) {
        return;
    }
    
    for (NSInteger index = 0; index < self.locations.count; ++index) {
        Location *location = self.locations[index];
        if ([location.locationId isEqualToNumber:defaultLocationId]) {
            [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index]
                        byExtendingSelection:NO];
            break;
        }
    }
}

#pragma mark - Buttons Actions

- (IBAction)didClickSaveButton:(id)sender {
    if (self.locations.count > self.tableView.selectedRow) {
        Location *location = self.arrayController.arrangedObjects[self.tableView.selectedRow];
        [DataManager shared].selectedLocation = location;
    }
    
    if ([self.presentingViewController isKindOfClass:[LoginViewController class]]) {
        [self presentViewController:[SettingsViewController new]
                           animator:[PresentationAnimator new]];
    } else {

    }
}

@end

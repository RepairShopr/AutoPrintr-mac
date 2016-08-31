//
//  SelectLocationViewController.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 30/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "SelectLocationViewController.h"
#import "DataManager.h"

@interface SelectLocationViewController ()
@property (weak) IBOutlet NSTextField *selectedLocationLabel;

@property (strong, nonatomic) NSArray *locations;
@end

@implementation SelectLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locations = [DataManager shared].loggedInUser.locations;
}

@end

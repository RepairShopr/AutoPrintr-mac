//
//  AppDelegate.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 29/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *mainMenu;

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)awakeFromNib {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.menu = self.mainMenu;
    self.statusItem.image = [NSImage imageNamed:@"menuItemIcon"];
    self.statusItem.title = @"AutoPrintr";
#warning need to investigate this
    self.statusItem.title = @"AutoPrintr";
    self.statusItem.highlightMode = YES;
}

- (IBAction)didClickLoginButton:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    
    self.loginViewController = [LoginViewController new];
    [self.window.contentView addSubview:self.loginViewController.view];
    [[self.loginViewController view] setFrame:[[self.window contentView] bounds]];
    
    [self.window makeKeyAndOrderFront:nil];
}

- (IBAction)didClickQuitButton:(id)sender {
    [NSApp terminate:nil];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

//
//  AppDelegate.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 29/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectLocationViewController.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "PusherManager.h"
#import "DataManager.h"

@interface AppDelegate () <LoginDelegate>
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *mainMenu;

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) LoginManager *loginManager;
@property (strong) IBOutlet NSMenuItem *loginMenuItem;
@property (strong, nonatomic) NSMenuItem *logoutItem;

@property (strong, nonatomic) SelectLocationViewController *selectLocationViewController;
@property (strong, nonatomic) NSWindow *locationsWindow;
@property (strong, nonatomic) NSMenuItem *locationsItem;

@property (strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) NSWindow *settingsWindow;
@property (strong, nonatomic) NSMenuItem *settingsItem;

@end

@implementation AppDelegate

#pragma mark - Menu

- (void)awakeFromNib {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.menu = self.mainMenu;
    self.statusItem.image = [NSImage imageNamed:@"menuItemIcon"];
    self.statusItem.highlightMode = YES;
}

#pragma mark - Buttons Actions

- (IBAction)didClickLoginButton:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];

    self.loginViewController = [LoginViewController createLoginManager:self.loginManager
                                                              delegate:self];
    [self.window.contentView addSubview:self.loginViewController.view];
    [[self.loginViewController view] setFrame:[[self.window contentView] bounds]];

    [self.window makeKeyAndOrderFront:nil];
}

- (void)didClickLocationButton:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];

    self.locationsWindow = [[NSWindow alloc] initWithContentRect:self.window.frame
                                                       styleMask:NSTitledWindowMask | NSClosableWindowMask
                                                         backing:NSBackingStoreBuffered
                                                           defer:NO];
    self.locationsWindow.releasedWhenClosed = NO;
    
    self.selectLocationViewController = [SelectLocationViewController new];
    [self.locationsWindow.contentView addSubview:self.selectLocationViewController.view];
    [[self.selectLocationViewController view] setFrame:[self.locationsWindow.contentView bounds]];
    
    [self.locationsWindow makeKeyAndOrderFront:self];
}

- (void)didClickSettingsButton {
    [NSApp activateIgnoringOtherApps:YES];
    
    self.settingsWindow = [[NSWindow alloc] initWithContentRect:self.window.frame
                                                       styleMask:NSTitledWindowMask | NSClosableWindowMask
                                                         backing:NSBackingStoreBuffered
                                                           defer:NO];
    self.settingsWindow.releasedWhenClosed = NO;
    
    self.settingsViewController = [SettingsViewController new];
    [self.settingsWindow.contentView addSubview:self.settingsViewController.view];
    [[self.settingsViewController view] setFrame:[self.settingsWindow.contentView bounds]];
    
    [self.settingsWindow makeKeyAndOrderFront:self];
}

- (void)didClickLogoutButton {
    [self.mainMenu removeItem:self.locationsItem];
    [self.mainMenu removeItem:self.settingsItem];
    [self.mainMenu removeItem:self.logoutItem];
    [self.mainMenu insertItem:self.loginMenuItem atIndex:0];
    [self.loginManager logoutUser];
}

- (IBAction)didClickQuitButton:(id)sender {
    [NSApp terminate:nil];
}

#pragma mark - Login Delegate

- (void)loginDidSucceed {
    [self addLocationOption];
    [self addSettingsOption];
    [self addLogoutOption];
}

#pragma mark - Menu Options

- (void)addLocationOption {
    [self.mainMenu removeItem:self.loginMenuItem];
    
    self.locationsItem = [[NSMenuItem alloc] initWithTitle:@"Locations"
                                                           action:@selector(didClickLocationButton:)
                                                    keyEquivalent:@""];
    [self.mainMenu insertItem:self.locationsItem atIndex:0];
}

- (void)addSettingsOption {
    if (self.settingsItem && [self.mainMenu.itemArray containsObject:self.settingsItem]) {
        return;
    }
    
    self.settingsItem = [[NSMenuItem alloc] initWithTitle:@"Settings"
                                                   action:@selector(didClickSettingsButton)
                                            keyEquivalent:@""];
    [self.mainMenu insertItem:self.settingsItem atIndex:1];
}

- (void)addLogoutOption {
    self.logoutItem = [[NSMenuItem alloc] initWithTitle:@"Log out"
                                                 action:@selector(didClickLogoutButton)
                                          keyEquivalent:@""];
    [self.mainMenu insertItem:self.logoutItem atIndex:2];
}

#pragma mark - App Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.loginManager = [LoginManager new];
    if ([self.loginManager shouldAutoLogin]) {
        [self.loginManager performAutoLoginWithCompletionBlock:^(BOOL succeed, NSString *errorMessage) {
            if (succeed) {
                [self loginDidSucceed];
            }
        }];
    }
}

@end

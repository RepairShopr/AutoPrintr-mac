//
//  LoginViewController.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 29/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "LoginViewController.h"
#import "SelectLocationViewController.h"
#import "NSViewController+Alert.h"
#import "SettingsViewController.h"
#import "PresentationAnimator.h"
#import "GetRegistersRequest.h"
#import "LoginRequest.h"
#import "DataManager.h"
#import "User.h"

@interface LoginViewController ()
@property (weak) IBOutlet NSTextField *loginTextField;
@property (weak) IBOutlet NSSecureTextField *passwordTextField;

@property (strong, nonatomic) LoginManager *loginManager;
@property (weak, nonatomic) id<LoginDelegate> delegate;
@end

@implementation LoginViewController

#pragma mark - Constructor

+ (instancetype)createLoginManager:(LoginManager *)loginManager delegate:(id<LoginDelegate>)delegate {
    LoginViewController *viewController = [self new];
    
    viewController.loginManager = loginManager;
    viewController.delegate = delegate;
    
    return viewController;
}

#pragma mark - Buttons Actions

- (IBAction)didClickLoginButton:(id)sender {
    [self.loginManager loginUserWithEmail:self.loginTextField.stringValue
                                 password:self.passwordTextField.stringValue
                          completionBlock:^(BOOL succeed, NSString *errorMessage) {
                              if (succeed) {
                                  [self.delegate loginDidSucceed];
                                  
                                  if (! [[DataManager shared].loggedInUser.locations count]) {
                                      [self presentViewController:[SettingsViewController new]
                                                         animator:[PresentationAnimator new]];
                                  } else {
                                      [self presentViewController:[SelectLocationViewController new]
                                                         animator:[PresentationAnimator new]];
                                  }
                              } else {
                                  [self showAlertWithMessage:@"Error" details:errorMessage];
                              }
                          }];
}

@end

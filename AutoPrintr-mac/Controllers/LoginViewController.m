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
#import "PresentationAnimator.h"
#import "LoginRequest.h"


@interface LoginViewController ()
@property (weak) IBOutlet NSTextField *loginTextField;
@property (weak) IBOutlet NSSecureTextField *passwordTextField;
@end

@implementation LoginViewController

#pragma mark - Buttons Actions

- (IBAction)didClickLoginButton:(id)sender {
    NSLog(@"click login");
    [self runLoginRequest];
}

#pragma mark - Request

- (void)runLoginRequest {
    LoginRequest *request = [LoginRequest requestWithEmail:self.loginTextField.stringValue
                                                  password:self.passwordTextField.stringValue];
    request.hasCustomDisplayErrorMessage = YES;
    
    [request setSuccess:^(id request, id response) {
        [self presentViewController:[SelectLocationViewController new]
                           animator:[PresentationAnimator new]];
    }];
    
    [request setError:^(id request, NSError *error) {
        [self showAlertWithMessage:@"Error" details:@"Invalid credentials."];
    }];
    
    [request runRequest];
}

@end

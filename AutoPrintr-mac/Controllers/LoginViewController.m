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
#import "GetRegistersRequest.h"
#import "LoginRequest.h"
#import "DataManager.h"
#import "User.h"

@interface LoginViewController ()
@property (weak) IBOutlet NSTextField *loginTextField;
@property (weak) IBOutlet NSSecureTextField *passwordTextField;

@property (weak, nonatomic) id<LoginDelegate> delegate;
@end

@implementation LoginViewController

- (void)viewWillAppear {
    [super viewWillAppear];
    if ([DataManager shared].loggedInUser) {
        self.loginTextField.stringValue = [DataManager shared].loggedInUser.email;
    }
}

#pragma mark - Constructor

+ (instancetype)createWithDelegate:(id<LoginDelegate>)delegate {
    LoginViewController *viewController = [self new];
    
    viewController.delegate = delegate;
    
    return viewController;
}

#pragma mark - Buttons Actions

- (IBAction)didClickLoginButton:(id)sender {
    [self runLoginRequest];
}

#pragma mark - Request

- (void)runLoginRequest {
    LoginRequest *request = [LoginRequest requestWithEmail:self.loginTextField.stringValue
                                                  password:self.passwordTextField.stringValue];
    request.hasCustomDisplayErrorMessage = YES;
    
    [request setSuccess:^(id request, User *user) {
        [self runRegistersRequest];
    }];
    
    [request setError:^(id request, NSError *error) {
        [self showAlertWithMessage:@"Error" details:@"Invalid credentials."];
    }];
    
    [request runRequest];
}

- (void)runRegistersRequest {
    GetRegistersRequest *request = [GetRegistersRequest request];
    
    [request setSuccess:^(id request, id response) {
        [self.delegate loginDidSucceed];
        [self presentViewController:[SelectLocationViewController new]
                           animator:[PresentationAnimator new]];
    }];
    
    [request setError:^(id request, NSError *error) {
        
    }];
    
    [request runRequest];
}

@end

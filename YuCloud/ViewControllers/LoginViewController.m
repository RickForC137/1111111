//
//  LoginViewController
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "YuAccountManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Login";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Signup" style:UIBarButtonItemStylePlain target:self action:@selector(EnterSignup:)];
    
    [self checkInputContent];
}

- (void)EnterSignup:(BOOL)animated
{
    AppDelegate *tempAppDelegate = getAppDelegate();
    [tempAppDelegate showSignup:YES];
}

- (IBAction)UserMobileNumberChanged:(id)sender
{
    [self checkInputContent];
}

- (IBAction)UserPasswordChanged:(id)sender
{
    [self checkInputContent];
}

- (IBAction)LoginButtonPressed:(id)sender
{
    YuAccountManager *manager = [[YuAccountManager manager] initWithServerIP:@"192.168.1.1"];
    [manager startLogin];
}

- (void)checkInputContent
{
    if([[_userNumber text] length] == 0 || [[_userPassword text] length] == 0)
    {
        [_loginBtn setEnabled:NO];
    }
    else
    {
        [_loginBtn setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


@end

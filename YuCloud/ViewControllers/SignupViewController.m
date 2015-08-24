//
//  SignupViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "SignupViewController.h"
#import "SmsVerifyViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)signupButtonPressed:(id)sender
{
    SmsVerifyViewController *vc = [[SmsVerifyViewController alloc] initWithNibName:@"SmsVerify" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  OneDeviceViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "OneDeviceViewController.h"
#import "AppDelegate.h"

@interface OneDeviceViewController ()

@end

@implementation OneDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self hidesBarsOnTap:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self hidesBarsOnTap:NO];
}

- (void)hidesBarsOnTap:(BOOL)hide
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainNavigationController setHidesBarsOnTap:hide];
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

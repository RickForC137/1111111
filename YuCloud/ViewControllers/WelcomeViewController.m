//
//  WelcomeViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "ScrollPageView.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Welcome";
    
    [self.navigationController.navigationBar setHidden:YES];
    
    CGRect rectPage = self.view.bounds;
    rectPage.origin.y += 20;            //status bar
    rectPage.size.height -= 100;
    ScrollPageView *scrollPage = [[ScrollPageView alloc]initWithFrame:rectPage];
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"watch1"]];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"watch2"]];
    UIImageView *imageView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"watch3"]];
    
    scrollPage.autoScrollDelayTime = 3.0;
    scrollPage.delegate = self;
    NSMutableArray *viewsArray = [[NSMutableArray alloc]initWithObjects:imageView1, imageView2, imageView3, nil];
    NSMutableArray *imgArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"watch1"], [UIImage imageNamed:@"watch2"], [UIImage imageNamed:@"watch3"], nil];
    [scrollPage setViewsArray:viewsArray];
    [scrollPage setImageArray:imgArray];
    [self.view addSubview:scrollPage];
    [scrollPage shouldAutoShow:YES];
    
    //show the Enter button
    CGRect rectBtn = CGRectMake(0, 0, 80, 40);
    rectBtn.origin.x = (self.view.bounds.size.width - rectBtn.size.width) / 2.0;
    rectBtn.origin.y = self.view.bounds.size.height - 70;
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterBtn setFrame:rectBtn];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(DismissWelcome) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:enterBtn];
}

- (void)DismissWelcome
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainNavigationController popViewControllerAnimated:NO];
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

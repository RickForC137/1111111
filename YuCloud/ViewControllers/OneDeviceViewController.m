//
//  OneDeviceViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "OneDeviceViewController.h"
#import "AppDelegate.h"
#import "MAMapKit/MAMapKit.h"

@interface OneDeviceViewController () < MAMapViewDelegate >


@property(nonatomic,strong)MAMapView            *mapView;
@end

@implementation OneDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //高德地图相关
    [MAMapServices sharedServices].apiKey = @"3abed93460249f28a8781e219a5cac53";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Device Location";
    
    CGRect rectStatus;
    rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectMain = self.view.bounds;
    CGRect rectMap = rectMain;
    rectMap.origin.y += rectStatus.size.height;
    rectMap.size.height -= rectStatus.size.height;
    
    //toolbar
    rectMap.origin.y += 44;
    rectMap.size.height -= 44;
    
    NSUInteger bottomBarHeight = 80;
    rectMap.size.height -= bottomBarHeight;
    
    self.mapView = [[MAMapView alloc] initWithFrame:rectMap];
    [self.view addSubview:self.mapView];
    
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.mapView setPausesLocationUpdatesAutomatically:NO];
    
    CGRect rectCompass = rectMap;
    rectCompass.origin.x = 8;
    rectCompass.origin.y = rectCompass.size.height - 22 + 44;
    rectCompass.size.width = 20;
    rectCompass.size.height = 20;
    
    UIButton *btnCompass = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCompass.frame = rectCompass;
    [btnCompass setBackgroundImage:[UIImage imageNamed:@"compass"] forState:UIControlStateNormal];
    [btnCompass addTarget:self action:@selector(LocateCurrentPos) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCompass];
    
}

- (void)LocateCurrentPos
{
    
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
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.mainNavigationController setHidesBarsOnTap:hide];
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

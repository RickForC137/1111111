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
#import "DeviceMenuView.h"
#import "DeviceInteractionViewController.h"
#import "DeviceWarningViewController.h"
#import "DeviceSettingsViewController.h"

@interface OneDeviceViewController () < MAMapViewDelegate, DeviceMenuDelegate >


@property(nonatomic,strong)MAMapView            *mapView;
@property(nonatomic,strong)MAUserLocation       *currPosition;
@end


#define DEVICE_VIEW_DEVICE_MENU_HEIGHT  46
@implementation OneDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //高德地图相关
    [MAMapServices sharedServices].apiKey = @"3abed93460249f28a8781e219a5cac53";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Device Location";
    
    CGRect rectMain = self.view.bounds;
    CGRect rectMap = rectMain;
    
    //status bar
    rectMap.origin.y += GetStatusBarHeight();
    rectMap.size.height -= GetStatusBarHeight();
    
    //toolbar
    rectMap.origin.y += GetNavigationBarHeight();
    rectMap.size.height -= GetNavigationBarHeight();
    
    //device menu bar
//    rectMap.size.height -= DEVICE_VIEW_DEVICE_MENU_HEIGHT;
    
    self.mapView = [[MAMapView alloc] initWithFrame:rectMap];
    [self.view addSubview:self.mapView];
    
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowsCompass:NO];
    [self.mapView setShowsScale:NO];
    MACoordinateRegion region;
    region.center.latitude = 31.913312682074096;
    region.center.longitude = 118.81326862389281;
    region.span.latitudeDelta = 0.040990883274265144;
    region.span.longitudeDelta = 0.030031073499415584;
    [self.mapView setRegion:region];
    
    //here we do not follow user's position
    [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
    
    NSUInteger compassSize = 20;
    CGRect rectCompass = rectMap;
    rectCompass.origin.x = 8;
    rectCompass.origin.y = rectCompass.origin.y + rectCompass.size.height - DEVICE_VIEW_DEVICE_MENU_HEIGHT;
    rectCompass.origin.y -= compassSize;
    rectCompass.size.width = compassSize;
    rectCompass.size.height = compassSize;
    
    UIButton *btnCompass = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCompass.frame = rectCompass;
    [btnCompass setBackgroundImage:[UIImage imageNamed:@"compass"] forState:UIControlStateNormal];
    [btnCompass addTarget:self action:@selector(LocateCurrentPos) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCompass];
    
    //here we create a menu like wechat app
    CGRect rectMenu = self.view.bounds;
    rectMenu.origin.y = rectMenu.size.height - DEVICE_VIEW_DEVICE_MENU_HEIGHT;
    rectMenu.size.height = DEVICE_VIEW_DEVICE_MENU_HEIGHT;
    rectMenu = CGRectInset(rectMenu, 4, 4);
    DeviceMenuView *deviceMenu = [[DeviceMenuView alloc] initWithFrame:rectMenu];
    deviceMenu.layer.cornerRadius = 8;
    deviceMenu.layer.borderWidth = 1;
    deviceMenu.layer.borderColor = [[UIColor purpleColor] CGColor];
    deviceMenu.layer.masksToBounds = YES;
    deviceMenu.delegate = self;
    
    //here is the main init entry
    [deviceMenu initDeviceMenu];
    [self.view addSubview:deviceMenu];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(_currPosition == nil)
    {
        //first time location
        [self LocateCurrentPos];
        _currPosition = userLocation;
    }
}

- (void)LocateCurrentPos
{
    MACoordinateRegion region = self.mapView.region;
    region.center = self.mapView.userLocation.coordinate;
    
    region.span.latitudeDelta = 0.03;
    region.span.longitudeDelta = 0.03;
    
    [self.mapView setRegion:region animated:YES];
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

- (void)onActionInteraction
{
    DeviceInteractionViewController *vc = [[DeviceInteractionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onActionWarning
{
    DeviceWarningViewController *vc = [[DeviceWarningViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onActionSettings
{
    DeviceSettingsViewController *vc = [[DeviceSettingsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hidesBarsOnTap:(BOOL)hide
{
//    AppDelegate *tempAppDelegate = getAppDelegate();
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

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
#import "DeviceControlBar.h"
#import "DeviceInteractionViewController.h"
#import "DeviceActivityViewController.h"
#import "DeviceSettingsViewController.h"
#import "RouteViewController.h"

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"route"] style:UIBarButtonItemStylePlain target:self action:@selector(openRouteView)];
    CGRect rectMain = self.view.bounds;
    CGRect rectMap = rectMain;
    
    //status bar
    rectMap.origin.y += GetStatusBarHeight();
    rectMap.size.height -= GetStatusBarHeight();
    
    //toolbar
    rectMap.origin.y += GetNavigationBarHeight();
    rectMap.size.height -= GetNavigationBarHeight();
    
    _mapView = [[MAMapView alloc] initWithFrame:rectMap];
    [self.view addSubview:_mapView];
    
    [_mapView setDelegate:self];
    [_mapView setShowsUserLocation:NO];
    [_mapView setShowsCompass:NO];
    [_mapView setShowsScale:NO];
    
    //here we do not follow user's position
    [_mapView setUserTrackingMode:MAUserTrackingModeNone animated:NO];
    
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
    DeviceControlBar *deviceMenu = [[DeviceControlBar alloc] initWithFrame:rectMenu];
    deviceMenu.delegate = self;
    
    //setting default rect need to be delayed, according to AMAP
    [self performSelector:@selector(delaySetDefaultRect) withObject:nil afterDelay:0.01];
    
    //here is the main init entry
    [deviceMenu initDeviceMenu];
    [self.view addSubview:deviceMenu];
}

- (void)delaySetDefaultRect
{
    //default region is PRC
    [_mapView setVisibleMapRect:MAMapRectMake(185869059.60193774, 67920576.65084286, 53678011.05177255, 86314241.771250263) animated:NO];
}

- (void)openRouteView
{
    RouteViewController *vc = [[RouteViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    MACoordinateRegion region = _mapView.region;
    region.center = CLLocationCoordinate2DMake(31.924868258470688, 118.81126655232617);     //device position
    
    region.span.latitudeDelta = 0.03;
    region.span.longitudeDelta = 0.03;
    
    [_mapView setRegion:region animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)onActionCall
{
    NSString *number = @"18625176639";
    number = [@"telprompt://" stringByAppendingString:number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
}

- (void)onActionHeart
{

    
}

- (void)onActionSpeak
{

    
}

- (void)onActionMonitoring
{

    
}

- (void)onActionInteraction
{
    DeviceInteractionViewController *vc = [[DeviceInteractionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onActionActivity
{
    DeviceActivityViewController *vc = [[DeviceActivityViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onActionSettings
{
    DeviceSettingsViewController *vc = [[DeviceSettingsViewController alloc] init];
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

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
#import "DeviceInfoBar.h"
#import "DeviceInteractionViewController.h"
#import "DeviceActivityViewController.h"
#import "DeviceSettingsViewController.h"
#import "RouteViewController.h"
#import "YuMapView.h"
#import "YuMapAnnotationView.h"

@interface OneDeviceViewController () < MAMapViewDelegate, DeviceControlDelegate >


@property(nonatomic,strong)YuMapView                *mapView;
@property(nonatomic,assign)CLLocationCoordinate2D   deviceLocation;
@property(nonatomic,assign)CLLocationCoordinate2D   userLocation;
@property(nonatomic,strong)UIButton                 *btnCompass;
@property(nonatomic,strong)DeviceControlBar         *deviceControlBar;
@property(nonatomic,strong)DeviceInfoBar            *deviceInfoBar;

@end


#define DEVICE_VIEW_DEVICE_MENU_HEIGHT  50
#define DEVICE_VIEW_DEVICE_INFO_HEIGHT  80

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
    
    _mapView = [[YuMapView alloc] initWithFrame:rectMap];
    [self.view addSubview:_mapView];
    
    [_mapView setDelegate:self];
    [_mapView setShowsUserLocation:YES];
    [_mapView setShowsCompass:NO];
    [_mapView setShowsScale:NO];
    
    //here we do not follow user's position
    [_mapView setUserTrackingMode:MAUserTrackingModeNone animated:NO];
    
    [self showDeviceLocationButton:rectMap show:YES];
    
    //here we create a menu like wechat app
    CGRect rectMenu = self.view.bounds;
    rectMenu.origin.y = rectMenu.size.height - DEVICE_VIEW_DEVICE_MENU_HEIGHT;
    rectMenu.size.height = DEVICE_VIEW_DEVICE_MENU_HEIGHT;
    rectMenu = CGRectInset(rectMenu, 4, 4);
    _deviceControlBar = [[DeviceControlBar alloc] initWithFrame:rectMenu];
    _deviceControlBar.delegate = self;
    
    //here is the main init entry
    [_deviceControlBar initDeviceControl];
    [self.view addSubview:_deviceControlBar];
    
    //setting default rect need to be delayed, according to AMAP
    [self performSelector:@selector(delaySetDefaultRect) withObject:nil afterDelay:0.01];
    
    //here set a temp value to device location
    _deviceLocation = CLLocationCoordinate2DMake(31.943286204632525, 118.80706220203611);
}

- (void)showDeviceLocationButton:(CGRect)rectMap show:(BOOL)show
{
    NSUInteger compassSize = 36, offset = 20;
    CGRect rectCompass = rectMap;
    rectCompass.origin.x = rectCompass.size.width - offset - compassSize;
    rectCompass.origin.y = rectCompass.origin.y + offset;
    rectCompass.size.width = compassSize;
    rectCompass.size.height = compassSize;
    
    _btnCompass = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCompass.frame = rectCompass;
    [_btnCompass setBackgroundImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [_btnCompass setShowsTouchWhenHighlighted:YES];
    [_btnCompass addTarget:self action:@selector(locateDevice) forControlEvents:UIControlEventTouchUpInside];
    
    _btnCompass.layer.cornerRadius = compassSize / 2.0;
    _btnCompass.layer.borderWidth = 1;
    _btnCompass.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _btnCompass.layer.masksToBounds = YES;
    
    [self.view addSubview:_btnCompass];
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
    if(_userLocation.latitude == 0 && _userLocation.longitude == 0)
    {
        //first time set the device centered
        _userLocation = userLocation.coordinate;
        
        MACoordinateRegion region = mapView.region;
        region.center = _userLocation;
        region.span.latitudeDelta = 0.03;
        region.span.longitudeDelta = 0.03;
        
        [mapView setRegion:region animated:YES];
    }
    
    //这行用来模拟设备位置更新
    [self deviceLocationDidUpdate:userLocation.coordinate];
}

- (void)deviceLocationDidUpdate:(CLLocationCoordinate2D)location
{
    _deviceLocation = location;
    [_mapView setCurrentLocation:location];
}

- (void)locateDevice
{
    MACoordinateRegion region = _mapView.region;
    if(region.span.latitudeDelta > 1.0 || region.span.longitudeDelta > 1.0)
    {
        region.center = _deviceLocation;
        region.span.latitudeDelta = 0.03;
        region.span.longitudeDelta = 0.03;
        
        [_mapView setRegion:region animated:YES];
    }
    
    [_mapView setCurrentLocation:_deviceLocation];
    [_mapView selectAnnotation:_mapView.deviceAnnot animated:YES];
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

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        YuMapAnnotationView *annotationView = (YuMapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[YuMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        annotationView.calloutEnabled = NO;
        annotationView.portrait = [UIImage imageNamed:@"baby"];
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    //点选annotation之后，将其居中，并且拉近
    if([view isKindOfClass:[YuMapAnnotationView class]])
    {
        YuMapAnnotationView *annot = (YuMapAnnotationView *)view;
        MACoordinateRegion region = mapView.region;
        region.center = annot.annotation.coordinate;
        if(region.span.latitudeDelta > 1.0 || region.span.longitudeDelta > 1.0)
        {
            region.span.latitudeDelta = 0.03;
            region.span.longitudeDelta = 0.03;
        }
        
        [mapView setRegion:region animated:YES];
    }
    
    [self showDeviceInfoBar:YES];
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    [self showDeviceInfoBar:NO];
}

- (void)showDeviceInfoBar:(BOOL)show
{
    if(_deviceInfoBar == nil)
    {
        CGRect rectInfo = self.view.bounds;
        rectInfo.origin.y = rectInfo.size.height - DEVICE_VIEW_DEVICE_MENU_HEIGHT;
        rectInfo.origin.y -= DEVICE_VIEW_DEVICE_INFO_HEIGHT;
        
        rectInfo.size.height = DEVICE_VIEW_DEVICE_INFO_HEIGHT;
        rectInfo = CGRectInset(rectInfo, 4, 4);
        
        _deviceInfoBar = [[DeviceInfoBar alloc] initWithFrame:rectInfo];
        _deviceInfoBar.alpha = 0.f;
        [self.view addSubview:_deviceInfoBar];
    }
    
    _deviceInfoBar.timeString = @"20分钟前设备在：";
    _deviceInfoBar.location = _deviceLocation;
    _deviceInfoBar.infoString = @"本次定位采用GPS定位，精度小于50米";
    
    CGFloat alpha = show? 1.f : 0.f;
    
    [UIView animateWithDuration:0.2f animations:^{
            _deviceInfoBar.alpha = alpha;
    }completion:^(BOOL finished){
    }];
}

@end





//
//  RouteViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/1.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "RouteViewController.h"
#import "AppDelegate.h"
#import "MAMapKit/MAMapKit.h"



@interface RouteViewController () < MAMapViewDelegate >


@property(nonatomic,strong)MAMapView            *mapView;

@end

@implementation RouteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"轨迹";
    
    CGRect rectMain = self.view.bounds;
    rectMain.origin.y += GetStatusBarHeight();
    rectMain.origin.y += GetNavigationBarHeight();
    rectMain.size.height -= rectMain.origin.y;
    
    //first is the date pad
    CGRect rect = rectMain;
    rect.size.height = 40;
    UIView *datePad = [[UIView alloc] initWithFrame:rect];
    datePad.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:datePad];
    
    rectMain.origin.y += rect.size.height;
    rectMain.size.height -= rect.size.height;
    
    //then the map view
    _mapView = [[MAMapView alloc] initWithFrame:rectMain];
    [self.view addSubview:_mapView];
    
    [_mapView setDelegate:self];
    [_mapView setShowsUserLocation:NO];
    [_mapView setShowsCompass:NO];
    [_mapView setShowsScale:NO];
    
    //here we do not follow user's position
    [_mapView setUserTrackingMode:MAUserTrackingModeNone animated:NO];
    
    //setting default rect need to be delayed, according to AMAP
    [self performSelector:@selector(delaySetDefaultRect) withObject:nil afterDelay:0.01];
}

- (void)delaySetDefaultRect
{
    //default region is PRC
    [_mapView setVisibleMapRect:MAMapRectMake(185869059.60193774, 67920576.65084286, 53678011.05177255, 86314241.771250263) animated:NO];
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

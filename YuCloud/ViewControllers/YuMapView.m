//
//  YuMapView.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/7.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "YuMapView.h"

@interface YuMapView()


@end

@implementation YuMapView


- (void)setCurrentLocation:(CLLocationCoordinate2D)location
{
    if(_deviceAnnot == nil)
    {
        _deviceAnnot = [[MAPointAnnotation alloc] init];
    }
    
    _deviceAnnot.coordinate = location;
    [self addAnnotation:_deviceAnnot];
}


@end

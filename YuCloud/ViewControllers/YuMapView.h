//
//  YuMapView.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/7.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAMapKit/MAMapKit.h"



@interface YuMapView : MAMapView

@property(nonatomic, strong)MAPointAnnotation       *deviceAnnot;

- (void)setCurrentLocation:(CLLocationCoordinate2D)location;
@end

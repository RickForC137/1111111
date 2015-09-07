//
//  DeviceInfoBar.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/2.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAMapKit/MAMapKit.h"

@interface DeviceInfoBar : UIView

@property(nonatomic, strong) NSString               *timeString;
@property(nonatomic, assign) CLLocationCoordinate2D location;
@property(nonatomic, strong) NSString               *infoString;

@end

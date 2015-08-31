//
//  DeviceTableViewCell.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/27.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceDataObject.h"

@interface DeviceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView    *imageMain;
@property (weak, nonatomic) IBOutlet UILabel        *labelMain;

@property (nonatomic, strong) DeviceDataObject      *deviceData;

@end

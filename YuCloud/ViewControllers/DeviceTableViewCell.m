//
//  DeviceTableViewCell.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/27.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "DeviceTableViewCell.h"
#import "AppDelegate.h"


@implementation DeviceTableViewCell
@synthesize deviceData = _deviceData;

- (void)awakeFromNib
{
    // Initialization code
    _labelMain.font = GetFontWithType(FontTypeDeviceCellLabel);
    
}

- (void)setDeviceData:(DeviceDataObject *)deviceData
{
    _deviceData = deviceData;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

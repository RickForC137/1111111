//
//  DeviceInfoBar.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/2.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "DeviceInfoBar.h"

@interface DeviceInfoBar()

@property(nonatomic, strong)UILabel         *timeLabel;
@property(nonatomic, strong)UILabel         *locationLabel;
@property(nonatomic, strong)UILabel         *infoLabel;

@end

@implementation DeviceInfoBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor darkGrayColor];
    
    CGRect rectMain = self.bounds;
    rectMain = CGRectInset(rectMain, 4, 2);
    NSUInteger height = rectMain.size.height / 3.0;
    
    CGRect rect = rectMain;
    rect.size.height = height;
    _timeLabel = [[UILabel alloc] initWithFrame:rect];
    _timeLabel.text = _timeString;
    _timeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_timeLabel];
    
    rect.origin.y += height;
    _locationLabel = [[UILabel alloc] initWithFrame:rect];
    _locationLabel.text = @"location adsfadsfasdf";
    _locationLabel.textColor = [UIColor whiteColor];
    [self addSubview:_locationLabel];
    
    rect.origin.y += height;
    _infoLabel = [[UILabel alloc] initWithFrame:rect];
    _infoLabel.text = _infoString;
    _infoLabel.textColor = [UIColor whiteColor];
    [self addSubview:_infoLabel];
    
    return self;
}

- (void)setTimeString:(NSString *)timeString
{
    _timeLabel.text = timeString;
}

- (void)setLocation:(CLLocationCoordinate2D)location
{
    
}

- (void)setInfoString:(NSString *)infoString
{
    _infoLabel.text = infoString;
}

@end

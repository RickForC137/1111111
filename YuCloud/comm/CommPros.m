//
//  CommPros.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/25.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#include "CommPros.h"
#import "AppDelegate.h"

double GetMinSizeWithFixedRatio(double w1, double h1, double w2, double h2)
{
    return 0.5;
}

CGFloat GetStatusBarHeight()
{
    CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
    return rect.size.height;
}

CGFloat GetNavigationBarHeight()
{
    return 44.0;
}

UIFont *GetFontWithType(FontType type)
{
    switch (type)
    {
        case FontTypeOptionsCell:
            return [UIFont fontWithName:@"Helvetica" size:18.f];
        case FontTypeUserName:
            return [UIFont fontWithName:@"Helvetica" size:20.f];
        case FontTypeDeviceCellLabel:
            return [UIFont fontWithName:@"Helvetica" size:20.f];
            case FontTypeDeviceMenuLabel:
            return [UIFont fontWithName:@"Helvetica" size:20.f];
        case FontTypeCount:
            break;
            
    }
    return nil;
}



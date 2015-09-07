//
//  CommPros.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/25.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#ifndef __YuCloud__CommPros__
#define __YuCloud__CommPros__

#import <UIKit/UIKit.h>
#include <stdio.h>

typedef NS_ENUM(NSInteger, FontType)
{
    FontTypeOptionsCell = 0,
    FontTypeUserName,
    FontTypeDeviceCellLabel,
    FontTypeDeviceControlLabel,
    
    //add new items before this item
    FontTypeCount
};

double GetMinSizeWithFixedRatio(double w1, double h1, double w2, double h2);
CGFloat GetStatusBarHeight();
CGFloat GetNavigationBarHeight();
UIFont *GetFontWithType(FontType type);

#endif /* defined(__YuCloud__CommPros__) */

//
//  PushToTalkButton.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/1.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, PushButtonState) {
    PushButtonStateNormal       = 0,
    PushButtonStatePushed       = 1 << 0,
    PushButtonStatePushedOut    = 1 << 1
};


@interface PushToTalkButton : UIButton

@property (nonatomic, assign)   PushButtonState     pushState;
@end

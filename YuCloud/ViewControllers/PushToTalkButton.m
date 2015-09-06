//
//  PushToTalkButton.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/1.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "PushToTalkButton.h"
#import "CommPros.h"

@implementation PushToTalkButton


- (void)setPushState:(PushButtonState)pushState
{
    //按理来说，按钮状态支持复合，目前暂不支持，后续有需求时扩展
    _pushState = pushState;
    
    NSString *strTitle = nil;
    switch (_pushState)
    {
        case PushButtonStateNormal:
            strTitle = @"按下 说话";
            break;
        case PushButtonStatePushed:
            strTitle = @"释放 发送";
            break;
        case PushButtonStatePushedOut:
            strTitle = @"释放 取消";
            break;
    }
    
    self.titleLabel.font = GetFontWithType(FontTypeDeviceMenuLabel);
    [self setTitle:strTitle forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

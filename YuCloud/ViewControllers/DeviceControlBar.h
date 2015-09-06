//
//  DeviceControlBar.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/28.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommPros.h"
#import "PushToTalkButton.h"

@protocol DeviceMenuDelegate < NSObject >

- (void)onActionInteraction;
- (void)onActionActivity;
- (void)onActionSettings;

@end

//menu item
@interface MenuItem : NSObject

@property (nonatomic, strong)   NSString            *title;
@property (nonatomic, strong)   UIImage             *image;
@property (nonatomic, assign)   CGRect              rect;
@property (nonatomic, assign)   SEL                 action;
@property (nonatomic, assign)   NSTextAlignment     alignment;
@property (nonatomic, assign)   BOOL                bPushToTalk;


- (instancetype)initWithName:(NSString *)title action:(SEL)action;


@end

//page views, such as first view, second view
@interface MenuPageView : UIView

@property (nonatomic, strong)       NSMutableArray              *arrMenuItems;
@property (nonatomic, assign)       id                          delegate;
@property (nonatomic, strong)       PushToTalkButton            *pushToTalkBtn;

@end

//the main view
@interface DeviceControlBar : UIView

@property (nonatomic, assign)       id <DeviceMenuDelegate>     delegate;


- (void)initDeviceMenu;
@end

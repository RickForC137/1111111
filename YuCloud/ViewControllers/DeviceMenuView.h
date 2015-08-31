//
//  DeviceMenuView.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/28.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommPros.h"

@protocol DeviceMenuDelegate < NSObject >

- (void)onActionInteraction;
- (void)onActionWarning;
- (void)onActionSettings;

@end

//menu item
@interface MenuItem : NSObject

@property (nonatomic, strong)   NSString            *title;
@property (nonatomic, strong)   UIImage             *image;
@property (nonatomic, assign)   CGRect              rect;
@property (nonatomic, assign)   SEL                 action;


- (instancetype)initWithName:(NSString *)title action:(SEL)action;


@end

//page views, such as first view, second view
@interface MenuPageView : UIView

@property (nonatomic, strong)       NSMutableArray              *arrMenuItems;
@property (nonatomic, assign)       id                          delegate;

@end

//the main view
@interface DeviceMenuView : UIView

@property (nonatomic, assign)       id <DeviceMenuDelegate>     delegate;


- (void)initDeviceMenu;
@end

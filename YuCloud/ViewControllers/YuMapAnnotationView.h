//
//  YuMapAnnotationView.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/7.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface YuMapAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImage   *portrait;
@property (nonatomic, assign) BOOL      calloutEnabled;
@property (nonatomic, strong) UIView    *calloutView;

@end

//
//  BlurredImageView.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/27.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurredImageView : UIView

- (id)initWithImage:(UIImage *)image;

@property (nonatomic, strong) UIImage   *image;           // default is nil
@property (nonatomic, assign) CGFloat   blurIntensity;    // default is 0.f


@end

//
//  YuCloudInterface.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/8.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface YuCloudInterface : AFHTTPSessionManager

+ (instancetype)sharedClient;


@end

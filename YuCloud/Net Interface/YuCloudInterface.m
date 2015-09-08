//
//  YuCloudInterface.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/8.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "YuCloudInterface.h"

static NSString * const YuCloudServerBaseURLString = @"https://api.app.net/";

@implementation YuCloudInterface

+ (instancetype)sharedClient
{
    static YuCloudInterface *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[YuCloudInterface alloc] initWithBaseURL:[NSURL URLWithString:YuCloudServerBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end

//
//  YuAccountManager.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/8.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "YuAccountManager.h"

@implementation YuAccountManager

+ (instancetype)manager
{
    return [[self alloc] initWithServerIP:@"192.168.1.1"];
}

- (instancetype)init
{
    self = [self initWithServerIP:nil];
    
    return self;
}

- (instancetype)initWithServerIP:(NSString *)ip
{
    self = [super init];
    
    [self setIpAddress:ip];
    
    return self;
}

- (void)setIpAddress:(NSString *)ipAddress
{
    _ipAddress = ipAddress;
}

- (void)startLogin
{
    
}


@end



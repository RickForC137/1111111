//
//  YuAccountManager.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/8.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuAccountManager : NSObject

@property(nonatomic, strong)NSString            *ipAddress;
+ (nullable instancetype)manager;

- (nullable instancetype)initWithServerIP:(nullable NSString *)ip NS_DESIGNATED_INITIALIZER;

- (void)startLogin;

@end

NS_ASSUME_NONNULL_END


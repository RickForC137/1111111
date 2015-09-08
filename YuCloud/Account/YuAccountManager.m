//
//  YuAccountManager.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/8.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "YuAccountManager.h"
#import "AFNetworking.h"
#import "CommPros.h"
#import "YuCloudInterface.h"
#import "AppDelegate.h"


@interface YuAccountManager()


@end

@implementation AccountInfo

@end

@implementation YuAccountManager

+ (instancetype)manager
{
    static YuAccountManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[YuAccountManager alloc] init];
    });
    
    return _sharedClient;
}

- (void)setCurrentAccountInfo:(NSDictionary *)info
{
    if(_accountInfo == nil)
    {
        _accountInfo = [[AccountInfo alloc] init];
    }
    
    _accountInfo.userid = [info objectForKey:@"id"];
    _accountInfo.name = [info objectForKey:@"username"];
    _accountInfo.signup_date = [info objectForKey:@"created_at"];
    _accountInfo.avatar_image = [[info objectForKey:@"avatar_image"] objectForKey:@"url"];
    _accountInfo.access_token = @"ALAKSDJFLKASFJLKALKSDFJ";
}

- (void)startLogin:(NSString *)name pass:(nullable NSString *)pass token:(nullable NSString *)token block:(nonnull void (^)(BOOL))block
{
    [[YuCloudInterface sharedClient] GET:@"/users/11111/" parameters:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = [responseObject valueForKeyPath:@"data"];
        [self setCurrentAccountInfo:dic];
        [getAppDelegate() updateLastAccount:_accountInfo];
        if(block)
        {
            block(YES);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if(block)
        {
            block(NO);
        }
    }];
    
}

- (void)startLogout
{
    
}

@end



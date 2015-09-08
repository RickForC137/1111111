//
//  YuAccountManager.h
//  YuCloud
//
//  Created by 熊国锋 on 15/9/8.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountInfo : NSObject

@property(nonatomic, strong) NSString           *userid;
@property(nonatomic, strong) NSString           *name;
@property(nonatomic, strong) NSDate             *signup_date;
@property(nonatomic, strong) NSString           *avatar_image;
@property(nonatomic, strong) NSString           *access_token;
@end

@interface YuAccountManager : NSObject

+ (nullable instancetype)manager;

@property(nonatomic, strong, readonly) AccountInfo         *accountInfo;

- (void)startLogin:(NSString *)name pass:(nullable NSString *)pass token:(nullable NSString *)token block:(void (^)(BOOL success))block;
- (void)startLogout;


@end

NS_ASSUME_NONNULL_END


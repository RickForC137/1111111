//
//  Account.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/26.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Account : NSManagedObject

@property (nonatomic, strong) NSString  *user_id;
@property (nonatomic, strong) NSString  *user_name;
@property (nonatomic, strong) NSString  *mobile_number;
@property (nonatomic, strong) NSString  *token;
@property (nonatomic, strong) NSDate    *signup_date;
@property (nonatomic, strong) NSDate    *last_signin;


@end

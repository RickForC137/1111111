//
//  Run.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/26.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface RunInfo : NSManagedObject

@property (nonatomic, assign) Boolean       first_run;
@property (nonatomic, strong) NSString      *last_account;
@property (nonatomic, strong) NSDate        *last_time;

@end


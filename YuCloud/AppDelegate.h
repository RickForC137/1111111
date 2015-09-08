//
//  AppDelegate.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/21.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CommPros.h"
#import "MainViewController.h"
#import "LeftSlideViewController.h"
#import "DeviceDataObject.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController       *LeftSlideVC;
@property (strong, nonatomic) UINavigationController        *mainNavigationController;


@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSFetchedResultsController      *fetchedResultsController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


- (void)showLogin:(BOOL)animated;
- (void)showSignup:(BOOL)animated;
- (void)showWelcome:(BOOL)animated;

@end

AppDelegate *getAppDelegate();

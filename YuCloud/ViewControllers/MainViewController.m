//
//  MainViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/21.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "AddNewDeviceViewController.h"
#import "OneDeviceViewController.h"

@interface MainViewController () < UITableViewDataSource, UITableViewDelegate >

@property(nonatomic,strong)UITableView          *tableView;
@end

@implementation MainViewController

#define MAIN_LIST_CELL_HEIGHT   100
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"YuCloud";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseLeftList)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDevice)];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 320;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //we have one header and two sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_LIST_CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rectHeader = [_tableView bounds];
    rectHeader.size.height = [self tableView:_tableView heightForHeaderInSection:0];
    UIView *headerView = [[UIView alloc] initWithFrame:rectHeader];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    CGRect rectWelcome = rectHeader;
    rectWelcome.origin.y = 0;
    rectWelcome.origin.x = 40;
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:rectWelcome];
    welcomeLabel.text = @"Hi, Welcome";
    welcomeLabel.textAlignment = NSTextAlignmentLeft;
    welcomeLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:welcomeLabel];
    
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeCustom];
    rectHeader.origin.y = 0;
    btnTap.frame = rectHeader;
    btnTap.backgroundColor = [UIColor clearColor];
    [btnTap addTarget:self action:@selector(touchOnUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnTap];
	
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect rectFooter = [_tableView bounds];
    rectFooter.size.height = [self tableView:_tableView heightForFooterInSection:0];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rectFooter];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.aliyun.com"]]];
    
    return webView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1)
    {
        cell.textLabel.text = @"Add new device...";
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    }
    
    return cell;
}

- (void)touchOnUserInfo
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate showLogin:YES];
}

- (void)addNewDevice
{
    AddNewDeviceViewController *vc = [[AddNewDeviceViewController alloc] initWithNibName:@"AddDevice" bundle:nil];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"Add new device";
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:YES];
}

- (void)ViewForOneDeviceEntry
{
    OneDeviceViewController *vc = [[OneDeviceViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"Device";
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1)
    {
        //this is the "Add new device" item
        [self addNewDevice];
    }
    else
    {
        [self ViewForOneDeviceEntry];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

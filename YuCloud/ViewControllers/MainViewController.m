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
#import "CommPros.h"
#import "DeviceTableViewCell.h"

@interface MainViewController () < UITableViewDataSource, UITableViewDelegate >

@property(nonatomic,strong)UITableView          *tableView;
@property(nonatomic,strong)UIView               *headView;
@property(nonatomic,strong)UIView               *fotterView;
@end

@implementation MainViewController

#define MAIN_LIST_CELL_HEIGHT   120
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"YuCloud";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseLeftList)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewDevice)];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftbackimage"]];
    
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = getAppDelegate();
    
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
    if(_headView)
    {
        return _headView;
    }
    
    CGRect rectHeader = [_tableView bounds];
    rectHeader.size.height = [self tableView:tableView heightForHeaderInSection:0];
    _headView = [[UIView alloc] initWithFrame:rectHeader];
    _headView.backgroundColor = [UIColor clearColor];
    
    CGRect rectHi = rectHeader;
    rectHi.size.width = 40;
    rectHi.size.height = 40;
    rectHi.origin.x = 10;
    rectHi.origin.y = (rectHeader.size.height - rectHi.size.height) / 2.0;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hi"]];
    imgView.frame = rectHi;
    [_headView addSubview:imgView];
    
    CGRect rectWelcome = rectHeader;
    rectWelcome.origin.y = 0;
    rectWelcome.origin.x = 60;
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:rectWelcome];
    welcomeLabel.text = @"Hi, Welcome";
    welcomeLabel.textAlignment = NSTextAlignmentLeft;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.font = GetFontWithType(FontTypeUserName);
    [_headView addSubview:welcomeLabel];
    
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeCustom];
    rectHeader.origin.y = 0;
    btnTap.frame = rectHeader;
    btnTap.backgroundColor = [UIColor clearColor];
    [btnTap addTarget:self action:@selector(touchOnUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:btnTap];
    
    return _headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(_fotterView)
    {
        return _fotterView;
    }
    
    CGRect rectFooter = [_tableView bounds];
    rectFooter.size.height = [self tableView:_tableView heightForFooterInSection:0];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rectFooter];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.aliyun.com"]]];
    
    _fotterView = webView;
    return _fotterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DeviceTableViewCell" owner:self options:nil];
        cell = _deviceCell;
        self.deviceCell = nil;
        
        if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1)
        {
            cell.imageMain.image = [UIImage imageNamed:@"device-add"];
            cell.labelMain.text = @"点击添加新设备";
            
            //special item, center the label
            cell.labelMain.centerY = cell.centerY;
        }
        else
        {
            cell.imageMain.image = [UIImage imageNamed:@"device-watch"];
            cell.labelMain.text = [NSString stringWithFormat:@"Device %ld", (long)indexPath.row];
            
            //here set the device data to the cell
            cell.deviceData = nil;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)touchOnUserInfo
{
    AppDelegate *tempAppDelegate = getAppDelegate();
    [tempAppDelegate showLogin:YES];
}

- (void)addNewDevice
{
    AddNewDeviceViewController *vc = [[AddNewDeviceViewController alloc] initWithNibName:@"AddDevice" bundle:nil];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"Add new device";
    
    AppDelegate *tempAppDelegate = getAppDelegate();
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:YES];
}

- (void)ViewForOneDeviceEntry
{
    OneDeviceViewController *vc = [[OneDeviceViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"Device";
    
    AppDelegate *tempAppDelegate = getAppDelegate();
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

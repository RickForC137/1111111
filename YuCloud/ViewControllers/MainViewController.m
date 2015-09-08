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
#import "YuAccountManager.h"

@interface MainViewController () < UITableViewDataSource, UITableViewDelegate >

@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)UIView                   *headViewForSection;
@property(nonatomic,strong)UIView                   *fotterViewForSection;
@property(nonatomic,strong)UIView                   *tableHeader;
@property(nonatomic,strong)UIActivityIndicatorView  *refreshIndicator;
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
    
    CGRect rect = self.view.bounds;
    rect.origin.y += GetStatusBarHeight();
    rect.origin.y += GetNavigationBarHeight();
    rect.size.height -= rect.origin.y;
    
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftbackimage"]];
    
    [self.view addSubview:_tableView];
    
    rect = _tableView.bounds;
    rect.size.height = 40;
    _tableHeader = [[UIView alloc] initWithFrame:rect];
    _tableHeader.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _tableHeader;
    
    if(/* DISABLES CODE */ (NO))
    {
        //透明navigation bar的方法
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_tableView reloadData];
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
    //here we do not need the inset
    UIEdgeInsets contentInset = tableView.contentInset;
    if(contentInset.top + contentInset.bottom != 0)
    {
        tableView.contentInset = UIEdgeInsetsZero;
    }
    
    //we have one header and two sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_LIST_CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(_headViewForSection)
    {
        return _headViewForSection;
    }
    
    CGRect rectHeader = [_tableView bounds];
    rectHeader.size.height = [self tableView:tableView heightForHeaderInSection:0];
    _headViewForSection = [[UIView alloc] initWithFrame:rectHeader];
    _headViewForSection.backgroundColor = [UIColor clearColor];
    
    CGRect rectHi = rectHeader;
    rectHi.size.width = 40;
    rectHi.size.height = 40;
    rectHi.origin.x = 10;
    rectHi.origin.y = (rectHeader.size.height - rectHi.size.height) / 2.0;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hi"]];
    imgView.frame = rectHi;
    [_headViewForSection addSubview:imgView];
    
    CGRect rectWelcome = rectHeader;
    rectWelcome.origin.y = 0;
    rectWelcome.origin.x = 60;
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:rectWelcome];
    welcomeLabel.text = @"Hi, Welcome";
    welcomeLabel.textAlignment = NSTextAlignmentLeft;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.font = GetFontWithType(FontTypeUserName);
    [_headViewForSection addSubview:welcomeLabel];
    
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeCustom];
    rectHeader.origin.y = 0;
    btnTap.frame = rectHeader;
    btnTap.backgroundColor = [UIColor clearColor];
    [btnTap addTarget:self action:@selector(touchOnUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [_headViewForSection addSubview:btnTap];
    
    return _headViewForSection;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(_fotterViewForSection)
    {
        return _fotterViewForSection;
    }
    
    CGRect rectFooter = [_tableView bounds];
    rectFooter.size.height = [self tableView:_tableView heightForFooterInSection:0];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rectFooter];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://login.weibo.cn"]]];
    
    _fotterViewForSection = webView;
    return _fotterViewForSection;
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
            cell.labelMain.text = @"虚拟体验设备";
            
            //here set the device data to the cell
            cell.deviceData = nil;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)touchOnUserInfo
{
    AccountInfo *info = [YuAccountManager manager].accountInfo;
    if([info.userid length] == 0)
    {
        AppDelegate *tempAppDelegate = getAppDelegate();
        [tempAppDelegate showLogin:YES];
    }
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

typedef NS_ENUM(NSInteger, RefreshStatus)
{
    RefreshStatusNormal = 0,
    RefreshStatusDraging,
    RefreshStatusRefreshing,
    
    //add new items before this item
    RefreshStatusCount
};

RefreshStatus refreshStatus = RefreshStatusNormal;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(refreshStatus == RefreshStatusNormal)
    {
        refreshStatus = RefreshStatusDraging;
        if(_refreshIndicator == nil)
        {
            _refreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            _refreshIndicator.hidesWhenStopped = NO;
            _refreshIndicator.center = _tableHeader.center;
            [_tableHeader addSubview:_refreshIndicator];
        }
        
        //initially, this is not animating
        _refreshIndicator.hidden = NO;
        _refreshIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_refreshIndicator stopAnimating];
    }
    else if(refreshStatus == RefreshStatusRefreshing)
    {
        //this for temp showing
        [self endRefreshingIndicator];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(refreshStatus == RefreshStatusDraging && fabs(scrollView.contentOffset.y) > _tableHeader.frame.size.height)
    {
        _refreshIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [_refreshIndicator startAnimating];
        refreshStatus = RefreshStatusRefreshing;
        
        [self startRefreshing];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(refreshStatus != RefreshStatusRefreshing)
    {
        [self endRefreshingIndicator];
    }
}

- (void)startRefreshing
{
    
}

- (void)endRefreshingIndicator
{
    refreshStatus = RefreshStatusNormal;
    [_refreshIndicator stopAnimating];
    _refreshIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

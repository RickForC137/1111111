//
//  MainViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/21.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

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
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 20, 18);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNewDevice) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
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

- (void)addNewDevice
{
    
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
    headerView.backgroundColor = [UIColor grayColor];
    
    CGRect rectWelcome = rectHeader;
    rectWelcome.origin.y = 0;
    rectWelcome.origin.x = 40;
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:rectWelcome];
    welcomeLabel.text = @"Hi, Welcome";
    welcomeLabel.textAlignment = NSTextAlignmentLeft;
    welcomeLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:welcomeLabel];
	
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

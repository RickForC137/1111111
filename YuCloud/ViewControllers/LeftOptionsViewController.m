//
//  LeftOptionsViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/23.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "LeftOptionsViewController.h"
#import "AppDelegate.h"

@interface LeftOptionsViewController () < UITableViewDataSource, UITableViewDelegate >

@property (nonatomic,strong) NSArray        *arrData;
@property (nonatomic,strong) UITableView    *tableView;
@end

@implementation LeftOptionsViewController

typedef NS_ENUM(NSInteger, LeftOptionsItems)
{
    LeftOptionsSettings = 0,
    LeftOptionsMyDevices,
    LeftOptionsMyFamily,
    LeftOptionsAbout,
    
    //add new items before this item
    LeftOptionsCount
};

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self initTableData];
}

- (void)initTableData
{
    _arrData = [[NSArray alloc]initWithObjects:@"Settings", @"My Devices", @"My Family", @"About", nil];
    assert([_arrData count] == LeftOptionsCount);
}

#define TABLE_VIEW_HEADER_SECTION_HEIGHT    160
#define TABLE_VIEW_HEADER_IMAGE_SIZE        80
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_VIEW_HEADER_SECTION_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rectHeader = [_tableView bounds];
    rectHeader.size.height = TABLE_VIEW_HEADER_SECTION_HEIGHT;
    UIView *headerView = [[UIView alloc] initWithFrame:rectHeader];
    headerView.backgroundColor = [UIColor clearColor];
    
    rectHeader.origin.y += 40;
    rectHeader.size.height -= 40;
    CGRect rectImg = rectHeader;
    
    rectImg.size.height = TABLE_VIEW_HEADER_IMAGE_SIZE;
    rectImg.size.width = TABLE_VIEW_HEADER_IMAGE_SIZE;
    rectImg.origin.x = (rectHeader.size.width - TABLE_VIEW_HEADER_IMAGE_SIZE) / 2.0;
    rectImg.origin.y += (rectHeader.size.height - TABLE_VIEW_HEADER_IMAGE_SIZE) / 2.0 - 20;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:rectImg];
    imgView.image = [UIImage imageNamed:@"head"];
    imgView.layer.cornerRadius = TABLE_VIEW_HEADER_IMAGE_SIZE / 2.0;
    imgView.layer.borderWidth = 1;
    imgView.layer.borderColor = [[UIColor grayColor] CGColor];
    imgView.layer.masksToBounds = YES;
    [headerView addSubview:imgView];
    
    CGRect rectName = rectHeader;
    rectName.origin.y = rectImg.origin.y + rectImg.size.height;
    rectName.size.height = rectHeader.size.height - rectImg.size.height;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:rectName];
    nameLabel.text = @"Xiong Guofeng";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:nameLabel];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrData count];
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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text = [_arrData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //close left slide view
    AppDelegate *tempAppDelegate = getAppDelegate();
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = [_arrData objectAtIndex:indexPath.row];
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

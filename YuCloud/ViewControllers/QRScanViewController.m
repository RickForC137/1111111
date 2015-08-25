//
//  QRScanViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/25.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "QRScanViewController.h"


@interface QRScanViewController ()

@end

@implementation QRScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(scanLocalPhoto)];
}

- (void)scanLocalPhoto
{

}

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
{
    
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

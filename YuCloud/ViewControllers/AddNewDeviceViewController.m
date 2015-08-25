//
//  AddNewDeviceViewController.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "AddNewDeviceViewController.h"
#import "QRScanViewController.h"

@interface AddNewDeviceViewController ()

@end

@implementation AddNewDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (BOOL)validateCamera
{
    return TRUE;
//    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (IBAction)QRScanSelected:(id)sender
{
    if ([self validateCamera])
    {
        [self showQRScanViewController];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

- (void)showQRScanViewController
{
    QRScanViewController *vc = [[QRScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)ManuallyScanSelected:(id)sender
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

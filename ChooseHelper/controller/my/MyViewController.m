//
//  MyViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MyViewController.h"
#import <Photos/Photos.h>

@interface MyViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.hidden = NO;
    
    
}

- (void)backBtnCliked:(UIButton *)sender
{
    [self showOkayCancelActionSheet];
}


- (void)showOkayCancelActionSheet {
    NSString *destructiveButtonTitle1 = NSLocalizedString(@"拍照", nil);
    NSString *destructiveButtonTitle2 = NSLocalizedString(@"从手机相册选则", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *destructiveAction1 = [UIAlertAction actionWithTitle:destructiveButtonTitle1 style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
        
        
    }];
    
    UIAlertAction *destructiveAction2 = [UIAlertAction actionWithTitle:destructiveButtonTitle2 style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if(status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 用户点击 "OK"

                        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        
                        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                        imagePickerController.delegate = self;
                        imagePickerController.allowsEditing = NO;
                        imagePickerController.sourceType = sourceType;
                        
                        [self presentViewController:imagePickerController animated:YES completion:^{}];
                        
                        
                        
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 用户点击 不允许访问
                        [MBProgressHUD showError:@"NO Permissions!"];
                    });
                }
            }];
        }
        
    }];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
    }];
    
    
    [alertController addAction:destructiveAction1];
    [alertController addAction:destructiveAction2];
    // Add the actions.
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - image picker delegte
// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
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

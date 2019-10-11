//
//  MyViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MyViewController.h"
#import <Photos/Photos.h>
#import "ChangeNameViewController.h"
#import "ChangesecretViewController.h"
#import "AboutViewController.h"
#import "VersionViewController.h"
#import "CZViewController.h"

@interface MyViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton *headerBtn;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy) NSArray *names;
@property(nonatomic,copy) NSArray *images;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewb = [UIView new];
    viewb.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewb];
    
    [viewb mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(233 - 20 + HEIGHT_STATUSBAR + 41);
        
    }];
    [self.view sendSubviewToBack:viewb];
    
    
    self.backImageView.image = kGetImage(@"my_top_bg");
    self.backImageView.backgroundColor = [UIColor blackColor];
    [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(233 - 20 + HEIGHT_STATUSBAR);
        
    }];
    
    
    
    UIButton *headerBtn = [UIButton new];
    [headerBtn setBackgroundImage:kGetImage(@"header") forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(showOkayCancelActionSheet) forControlEvents:UIControlEventTouchUpInside];
    headerBtn.layer.cornerRadius = 50;
    headerBtn.clipsToBounds = YES;
    [self.view addSubview:headerBtn];
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(-15);
        
    }];
    self.headerBtn = headerBtn;
    
    
    NSString *path_document = NSHomeDirectory();
    NSString *imagePath1 = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/header.png"]];
    
    UIImage *image = kGetImage(imagePath1);
    if (image != nil) {
        [self.headerBtn setBackgroundImage:kGetImage(imagePath1) forState:UIControlStateNormal];
    }
    
    
    UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:@"张三" textColor:[UIColor whiteColor]];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(headerBtn.mas_bottom).with.offset(13);
        
    }];
    
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:16] text:@"账户余额" textColor:[UIColor whiteColor]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(headerBtn.mas_left).with.offset(-24);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(label.mas_bottom).with.offset(11);
        
    }];
    
    UILabel *label2 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:16] text:@"10000.00" textColor:[UIColor whiteColor]];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(headerBtn.mas_right).with.offset(24);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(label.mas_bottom).with.offset(11);
        
    }];
    
    UIButton *czBtn = [UIButton new];
    [czBtn setBackgroundImage:kGetImage(@"to_cz") forState:UIControlStateNormal];
    [czBtn addTarget:self action:@selector(goToCZ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:czBtn];
    [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(133);
        make.height.mas_offset(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).with.offset(36);
        
    }];
    
    
    self.names = @[@"我的自选",@"修改用户名",@"修改密码",@"联系我们",@"版本信息"];
    self.images = @[@"m_1",@"m_3",@"m_4",@"m_5",@"m_6"];
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        //设置delegate和DataSouce
         _tableView.delegate = self;
         _tableView.dataSource = self;
         //添加到界面上
    _tableView.backgroundColor = [UIColor whiteColor];
         [self.view addSubview:_tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(42 * 5);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(czBtn.mas_bottom).with.offset(22);
        
    }];
    
    
    
    UIButton *loBtn = [UIButton new];
    [loBtn setBackgroundImage:kGetImage(@"lo") forState:UIControlStateNormal];
    [loBtn addTarget:self action:@selector(logOutBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loBtn];
    [loBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(154);
        make.height.mas_offset(38);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.tableView.mas_bottom).with.offset(46);
        
    }];
}

- (void)goToCZ
{
    CZViewController *vc = [[CZViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)logOutBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showOkayCancelActionSheet {
    NSString *destructiveButtonTitle1 = NSLocalizedString(@"拍照", nil);
    NSString *destructiveButtonTitle2 = NSLocalizedString(@"从手机相册选择", nil);
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
        else
        {
            NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            imagePickerController.sourceType = sourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{}];
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
    
    
    [self.headerBtn setBackgroundImage:resultImage forState:UIControlStateNormal];
    
    
    
    NSString *path_document = NSHomeDirectory();
    NSString *imagePath1 = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/header.png"]];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(resultImage) writeToFile:imagePath1 atomically:YES];
    
    
    
    
    
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}



//配置每个section(段）有多少row（行） cell
 //默认只有一个section
  -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return 5;
  }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 42;
}

  //每行显示什么东西
  -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      //给每个cell设置ID号（重复利用时使用）
      static NSString *cellID = @"cellID";

     //从tableView的一个队列里获取一个cell
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

     //判断队列里面是否有这个cell 没有自己创建，有直接使用
     if (cell == nil) {
         //没有,创建一个
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

     }
      cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     //使用cell
     cell.textLabel.text = self.names[indexPath.row];
      cell.imageView.image = kGetImage(self.images[indexPath.row]);
     return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"jump1" object:nil userInfo:nil];
    }
    else if (indexPath.row == 1) {
        
        ChangeNameViewController *vc = [[ChangeNameViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2) {
        
        ChangesecretViewController *vc = [[ChangesecretViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3) {
        
        AboutViewController *vc = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 4)
    {
        VersionViewController *vc = [[VersionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
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

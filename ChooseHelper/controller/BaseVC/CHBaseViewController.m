//
//  BaseViewController.m
//  MyStock
//
//  Created by Company on 2019/10/10.
//  Copyright © 2019 CoooooY. All rights reserved.
//

#import "CHBaseViewController.h"
@interface CHBaseViewController ()

@end

@implementation CHBaseViewController

@synthesize movementDistance;
@synthesize keyboardHeight;
@synthesize viewOriginalFrame;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    DLog(@"当前类<<<<<<<<<<<%@>>>>>>>>>>>>", NSStringFromClass(self.class));
    
    if ([self isShowNavigation]) {
        [self initNavigationBar];
    }
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    viewOriginalFrame = self.view.frame;
    //隐藏系统导航栏
    self.navigationController.navigationBarHidden = YES;
}

- (void)setBackgroundColor:(UIColor *)color {
    self.view.backgroundColor = color;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)isShowNavigation{
    return YES;
}

/**
 *  初始化导航栏
 */
-(void)initNavigationBar{
    //状态栏以下的导航高度
    static CGFloat NAVIGATION_HEIGHT = 44;
    //导航图标的高宽
    static CGFloat IMAGEVIEW_WH = 20;
    
    //左右点击view的宽度
    static CGFloat CLICK_VIEW_WIDTH = 70;
    //状态栏高度
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.navigationHeight = statusBarHeight + NAVIGATION_HEIGHT;
    
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  statusBarHeight + NAVIGATION_HEIGHT)];
    [self.view addSubview:self.navigationView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CLICK_VIEW_WIDTH, statusBarHeight, SCREEN_WIDTH - 2 * CLICK_VIEW_WIDTH, NAVIGATION_HEIGHT)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"";
    [self.navigationView addSubview:self.titleLabel];
    
    self.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, statusBarHeight, CLICK_VIEW_WIDTH, NAVIGATION_HEIGHT)];
    [self.navigationView addSubview:self.leftView];
    [self.leftView addTarget:self action:@selector(clickLeft)];
    
    self.leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(16, (NAVIGATION_HEIGHT - IMAGEVIEW_WH) / 2.0, IMAGEVIEW_WH, IMAGEVIEW_WH)];
    self.leftIV.image = [UIImage imageNamed:@"back"];
    self.leftIV.contentMode = UIViewContentModeScaleAspectFit;
    [self.leftView addSubview:self.leftIV];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - CLICK_VIEW_WIDTH, statusBarHeight, CLICK_VIEW_WIDTH, NAVIGATION_HEIGHT)];
    [self.navigationView addSubview:self.rightView];
    [self.rightView addTarget:self action:@selector(clickRight)];
    
    self.rightIV = [[UIImageView alloc]initWithFrame:CGRectMake(CLICK_VIEW_WIDTH - IMAGEVIEW_WH - 16, (NAVIGATION_HEIGHT - IMAGEVIEW_WH) / 2.0, IMAGEVIEW_WH, IMAGEVIEW_WH)];
    self.rightIV.image = [UIImage imageNamed:@"icon_edit"];
    self.rightIV.contentMode = UIViewContentModeScaleAspectFit;
    self.rightIV.hidden = YES;
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CLICK_VIEW_WIDTH - 16, NAVIGATION_HEIGHT)];
    self.rightLabel.text = @"";
    self.rightLabel.hidden = YES;
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.textColor = [UIColor whiteColor];
    
    [self.rightView addSubview:self.rightIV];
    [self.rightView addSubview:self.rightLabel];
  
    self.navigationView.backgroundColor = [UIColor colorFromRGBAHexCode:@"#1974F0"];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    self.titleLabel.text = [infoDic objectForKey:@"CFBundleDisplayName"];
    
    self.navIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBK"]];
    self.navIV.frame = self.navigationView.bounds;
    [self.navigationView addSubview:self.navIV];
    [self.navigationView sendSubviewToBack:self.navIV];
    self.titleLabel.text = self.title;
    
}

/**
 *  初始化UI
 */
-(void)initUI{
    //侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bkIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bkIV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bkIV.contentMode = UIViewContentModeScaleAspectFill;
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.bkIV];
    
    self.account = [[AccountDao sharedAccountDao] queryLoginUser];
}


-(void)clickLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickRight{
}


- (void)showAlert:(NSString *)string{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



//点击返回按钮
//-(BOOL) textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}


-(void)saveInfoByKey:(NSString *)key andValue:(NSObject *)value{
    
    //保存用户信息到本地
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}

-(id)getInfoByKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
   
}

/**
 *  显示等待
 */
-(void)showWaiting{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

/**
 *  隐藏等待
 */
-(void)dismissWaiting{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)dismissWaitingWithShowToast:(NSString *)msg{
    [self dismissWaiting];
    [self showToast:msg];
}

/**
 *  显示提示消息
 */
- (void)showToast:(NSString *)msg{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.margin = 10.f;
    //hud.offset = CGP
    hud.offset = CGPointMake(hud.offset.x, SCREEN_HEIGHT * 0.3333);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    DLog(@"当前类<<<<<<<<<<<%@>>>>>>>>>>>销毁了dealloc", NSStringFromClass(self.class));
}


@end

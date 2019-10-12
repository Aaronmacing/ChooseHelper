//
//  PlayViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "PlayViewController.h"
//导入系统框架
#import <AVFoundation/AVFoundation.h>
#import "ZQPlayerMaskView.h"
#import "AppDelegate.h"
#import "ClassTableViewCell.h"
#import "KsModel.h"

@interface PlayViewController ()<ZQPlayerDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{
    
}


/** 视频播放器*/
@property (nonatomic, strong) ZQPlayerMaskView *playerMaskView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PlayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.LearnInterFace = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.LearnInterFace = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = _vidModel.title;
    
    self.backImageView.image = kGetImage(@"p_bg1");
    [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(302 + HEIGHT_STATUSBAR);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        
    }];
    
    
    // 视频播放
    _playerMaskView = [[ZQPlayerMaskView alloc] init];
    _playerMaskView.delegate = self;
    _playerMaskView.isWiFi = YES; // 是否允许自动加载，
    _playerMaskView.titleLab.text = @"";
    [self.view addSubview:_playerMaskView];
    
    // 网络视频
//    NSString *videoUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    // 本地视频
    NSString *videoUrl = [[NSBundle mainBundle] pathForResource:self.vidModel.video ofType:@"mp4"];
    [_playerMaskView playWithVideoUrl:videoUrl];
    
    [_playerMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(362);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(258);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   self.tableView.backgroundColor = [UIColor whiteColor];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
   [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ClassTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ClassTableViewCell"];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   [self.view addSubview:self.tableView];
   
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.backImageView.mas_bottom).with.offset(0);
       make.bottom.mas_equalTo(self.view.mas_bottom);
       make.left.mas_equalTo(self.view.mas_left).with.offset(0);
       make.right.mas_equalTo(self.view.mas_right).with.offset(0);
       
   }];
    
}

-(void)setRArr:(NSArray *)rArr{
    _rArr = rArr;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = kGetImage(@"main_flag");
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(view.mas_top).with.offset(7);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(23);
            make.left.mas_equalTo(view.mas_left).with.offset(8);
        
    }];
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:17] text:@"相关课程" textColor:[UIColor colorWithHexString:@"#242E49" alpha:1]];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(imageView.mas_right).with.offset(8);
        make.width.mas_equalTo(203);
        make.height.mas_equalTo(23);
        make.top.mas_equalTo(imageView.mas_top).with.offset(0);
        
    }];
    
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _rArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ClassTableViewCell";
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ClassTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    KsModel * model = _rArr[indexPath.row];
    cell.nameLabel.text = model.title;
    cell.timeLabel.text = model.time;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KsModel * model = _rArr[indexPath.row];
    self.title = model.title;
    NSString *videoUrl = [[NSBundle mainBundle] pathForResource:model.video ofType:@"mp4"];
    [_playerMaskView playWithVideoUrl:videoUrl];
}

#pragma mark - 屏幕旋转
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

// 全屏需要重写方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator  {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait || orientation
        == UIDeviceOrientationPortraitUpsideDown) {
        // 隐藏导航栏

        [_playerMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(362);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
            make.height.mas_equalTo(258);
        }];
    }else {
        // 显示导航栏
        [_playerMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.right.mas_equalTo(self.view.mas_right);
                   make.left.mas_equalTo(self.view.mas_left);
                   make.top.equalTo(self.view.mas_top);
                   make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
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

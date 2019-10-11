//
//  MainViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MainViewController.h"
//导入系统框架
#import <AVFoundation/AVFoundation.h>

@interface MainViewController ()
@property (strong, nonatomic) AVPlayer *avPlayer;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"视频播放";

    //网络视频播放
    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSURL *url = [NSURL URLWithString:playString];
    
//    //本地视频播放
//    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"霍建华、赵丽颖 - 不可说" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:audioPath];

    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //初始化player对象
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 230);
    layer.backgroundColor = [UIColor clearColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    //1.保持纵横比；适合层范围内
    //2.保持纵横比；填充层边界
    //3.拉伸填充层边界
    /*
    第1种AVLayerVideoGravityResizeAspect是按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑；
    第2种AVLayerVideoGravityResizeAspectFill是以原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分就被切割了；
    第3种AVLayerVideoGravityResize是拉伸视频内容达到边框占满，但不按原比例拉伸，这里明显可以看出宽度被拉伸了。
     */
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    //视频播放
    [self.avPlayer play];
    //视频暂停
    //[self.avPlayer pause];
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

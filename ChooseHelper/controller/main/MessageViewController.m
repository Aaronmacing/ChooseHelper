//
//  MessageViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MessageViewController.h"
#import <WebKit/WebKit.h>
@interface MessageViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, assign) CGPoint keyBoardPoint;
@property (nonatomic, strong) WKWebView * Uni_BrowserView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"资讯详情";
    
    [self.view addSubview:self.Uni_BrowserView];
    [self.Uni_BrowserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.Uni_BrowserView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadingUrl]]];
    [MBManager showWaitingWithTitle:@"加载中"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [MBManager hideAlert];
}

#pragma mark - Lazy Loading
- (WKWebView *)Uni_BrowserView{
    
    if (!_Uni_BrowserView) {
        _Uni_BrowserView = [[WKWebView alloc] init];
        _Uni_BrowserView.UIDelegate = self;
        _Uni_BrowserView.navigationDelegate = self;
        _Uni_BrowserView.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _Uni_BrowserView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _Uni_BrowserView;
}

@end

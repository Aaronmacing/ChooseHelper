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
    
    [self.Uni_BrowserView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.absoluteString containsString:@"//itunes.apple.com/"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if (navigationAction.request.URL.scheme
              && ![navigationAction.request.URL.scheme hasPrefix:@"http"]
              && ![navigationAction.request.URL.scheme hasPrefix:@"file"])
    {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        if (navigationAction.targetFrame == nil) {
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    if (error.code == NSURLErrorUnsupportedURL) {
        NSString *urlString = error.userInfo[NSURLErrorFailingURLStringErrorKey];
        if (urlString) {
            NSURL *url = [NSURL URLWithString:urlString];
            if (url) {
                [UIApplication.sharedApplication openURL:url];
            }
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (error.code == NSURLErrorUnsupportedURL) {
        NSString *urlString = error.userInfo[NSURLErrorFailingURLStringErrorKey];
        if (urlString) {
            NSURL *url = [NSURL URLWithString:urlString];
            if (url) {
                [UIApplication.sharedApplication openURL:url];
            }
        }
    }
    
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
}

#pragma mark - WKUIDelegate

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    [Utils Uni_showAlertWithTitle:@"" message:message ? : @"" cancle:nil sure:@"确定" viewController:self handlerCompletion:^(NSInteger option) {
        if (option == 1) {
            completionHandler();
        }
    }];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    [Utils Uni_showAlertWithTitle:@"" message:message ? : @"" cancle:nil sure:@"确定" viewController:self handlerCompletion:^(NSInteger option) {
        if (option == 1) {
            completionHandler(YES);
        }
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Carry out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields.firstObject.text ? : @"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

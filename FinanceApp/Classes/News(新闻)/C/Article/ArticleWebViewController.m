//
//  ArticleWebViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/7.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "ArticleWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SettingFontViewController.h"

#import <UShareUI/UShareUI.h>

#define argumentWithFont @[@"small", @"middle", @"large"]

@interface ArticleWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"极链财经";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_fenxiang"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick)];
}

- (void)shareBtnClick {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_Link)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作


    }];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = k_white_color;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = k_home_barColor;
    
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = k_white_color;
        
        NSArray *title = @[@"字体大小", @"收藏", @"分享"];
        NSArray *icon = @[@"icon_setting_textsize", @"icon_shoucang", @"icon_fenxiang"];
        
        for (int i=0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(kScreenWidth/3*i, CalculateHeight(4), kScreenWidth/3, CalculateHeight(20));
            btn.tag = i;
            [btn setTitle:title[i] forState:UIControlStateNormal];
            [btn setTitleColor:k_black_color forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:icon[i]] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:btn];
        }
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 0, kScreenWidth, CalculateHeight(0.5));
        line.backgroundColor = k_line;
        [_bottomView addSubview:line];
    }
    return _bottomView;
}

- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        [self addWebView:urlString];
        [self.view addSubview:self.bottomView];
        self.fontSize = 16;
        
        [self addMasnory];
    }
    return self;
}

- (void)addMasnory {
    [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(CalculateHeight(44));
    }];
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(44)));
    }];
}

- (void)addWebView:(NSString *)urlStr {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:urlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10]];
    self.webView = webView;
    webView.delegate = self;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * requestString = request.URL.absoluteString;
    NSLog(@"请求的地址：%@",requestString);
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    [self clickSettingFontSizeWithContext:context];
    NSArray *arr = @[@100, @120, @140];
    NSInteger index = [[kNSUserDefaults valueForKey:user_webFontSize] integerValue];
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%ld%%'",
                          [arr[index] integerValue]];
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    
    [kNSUserDefaults setValue:[NSString stringWithFormat:@"%ld", (long)index] forKey:user_webFontSize];
//    [self clickCollectionWithContext:context];
//    [self clickShareWithContext:context];
}

- (void)clickSettingFontSizeWithContext:(JSContext *)context {
    WS(weakSelf);
    // oc 调用js方法
    NSString *jsString = [[NSString alloc] initWithFormat:@"openFont"];
    [context evaluateScript:jsString];
    
    
    SettingFontViewController *vc = [[SettingFontViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.fontBlock = ^(NSInteger index) {
        [[JSContext currentContext][@"articleFontSize"] callWithArguments:@[argumentWithFont[index]]];
            // 这里是js调用oc的方法的地方
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickCollectionWithContext:(JSContext *)context
{
    NSString *jsString = [NSString stringWithFormat:@"showCollectionResult"];
    [context evaluateScript:jsString];
}

- (void)clickShareWithContext:(JSContext *)context {
    // js调用oc的方法
    context[@"openShare"] = ^() {
      
    };
}

- (void)bottomBtnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            {
                SettingFontViewController *vc = [[SettingFontViewController alloc] init];
//                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//                vc.fontBlock = ^(NSInteger index) {
//                    [[JSContext currentContext][@"articleFontSize"] callWithArguments:@[argumentWithFont[index]]];
//                    // 这里是js调用oc的方法的地方
//                };
                
                vc.fontBlock = ^(NSInteger index) {
                    NSArray *arr = @[@100, @120, @140];
                    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%ld%%'",
                                          [arr[index] integerValue]];
                    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
                    [kNSUserDefaults setValue:[NSString stringWithFormat:@"%ld", (long)index] forKey:user_webFontSize];
                };
                [vc show];
//                [self presentViewController:vc animated:YES completion:nil];
//                [[UIApplication sharedApplication].keyWindow addSubview:vc];
            }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

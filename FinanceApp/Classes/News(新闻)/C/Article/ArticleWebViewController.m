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

#define argumentWithFont @[@"small", @"middle", @"large"]

@interface ArticleWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = k_white_color;
        
        NSArray *title = @[@"字体大小", @"收藏", @"分享"];
        NSArray *icon = @[@"icon_setting_textsize", @"icon_shoucang", @"icon_fenxiang"];
        
        for (int i=0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, CalculateHeight(30));
            btn.tag = i;
            [btn setTitle:title[i] forState:UIControlStateNormal];
            [btn setTitleColor:k_black_color forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:icon[i]] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:btn];
        }
        
        
    }
    return _bottomView;
}

- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        [self addWebView:urlString];
//        [self.view addSubview:self.bottomView];
        self.fontSize = 16;
        
        [self addMasnory];
    }
    return self;
}

- (void)setrighItem {
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(112), CalculateHeight(27))];
    img.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = img;
}


- (void)addMasnory {
    [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(CalculateHeight(44));
    }];
//    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(0);
//        make.left.right.offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(44)));
//    }];
}

- (void)addWebView:(NSString *)urlStr {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:urlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10]];
    
    webView.delegate = self;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * requestString = request.URL.absoluteString;
    NSLog(@"请求的地址：%@",requestString);
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [self setrighItem];
    [self clickSettingFontSizeWithContext:context];
    [self clickCollectionWithContext:context];
    [self clickShareWithContext:context];
}

- (void)clickSettingFontSizeWithContext:(JSContext *)context {
    WS(weakSelf);
    // oc 调用js方法
    NSString *jsString = [[NSString alloc] initWithFormat:@"openFont"];
    [context evaluateScript:jsString];
    
    
    SettingFontViewController *vc = [[SettingFontViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ArticleWebViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/7.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "ArticleWebViewController.h"

@interface ArticleWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIView *bottomView;

@end
#define K_FONT_SIZE_CHANGE_WEB_URL @"http://3g.fx678.com/news/detail/201508031037021902"
@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(112), CalculateHeight(27))];
    img.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = img;
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
        [self.view addSubview:self.bottomView];
        
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
//    webView.delegate = self;
}

- (void)bottomBtnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:  // 点击分享
        {
            
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

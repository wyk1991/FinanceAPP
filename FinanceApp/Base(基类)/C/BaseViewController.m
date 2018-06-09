//
//  BaseViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self addMasnory];
    [self registerNotification];
}

- (void)loadData {
    
}

- (void)addMasnory {}

- (void)registerNotification {}

- (void)removeNotification {}



- (void)baseViewControllerBackClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navColor = k_white_color;
    self.navigationController.navigationBar.translucent  = NO;
    self.view.backgroundColor = k_back_color;
    [self.navigationController.navigationBar setTintColor:k_main_color];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        // 设置导航栏字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : k_text_font_args(CalculateHeight(20))}];
}

/**
 导航栏背景色
 */
- (void)setNavColor:(UIColor *)navColor
{
    _navColor = navColor;
    if (![navColor isKindOfClass:[UIColor class]]) return;
    self.navigationController.navigationBar.barTintColor = navColor;
}

/**
 导航栏标题颜色
 */
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    if (![titleColor isKindOfClass:[UIColor class]]) return;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor}];
}

/**
 返回按钮颜色
 */
- (void)setBackItemColor:(UIColor *)backItemColor
{
    _backItemColor = backItemColor;
    if (![backItemColor isKindOfClass:[UIColor class]]) return;
    self.navigationController.navigationBar.tintColor = backItemColor;;
}

/**
 返回按钮
 
 @return 返回按钮
 */
- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_back"] style:UIBarButtonItemStylePlain target:self action:@selector(baseViewControllerBackClick:)];
        
    }
    return _backItem;
}

#pragma mark dealloc
- (void)dealloc {
    NSLog(@"%@ removesuccess!", NSStringFromClass([self class]));
    [self removeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end

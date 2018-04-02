//
//  MainTabBarController.m
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "MainTabBarController.h"
#import "NewsViewController.h"
#import "NewFlashViewController.h"
#import "SettingViewController.h"
#import "SituationViewController.h"

@interface MainTabBarController ()
{
    NewsViewController *_newsVc;
    NewFlashViewController *_newFlashVc;
    SettingViewController *_settingVc;
    SituationViewController *_situationVc;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [self setupTab];
}

- (void)initSubViews {
    
    _newsVc = [[NewsViewController alloc] init];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:_newsVc];
    
    _newFlashVc = [[NewFlashViewController alloc] init];
    UINavigationController *newFlashNav = [[UINavigationController alloc] initWithRootViewController:_newFlashVc];
    
    _settingVc = [[SettingViewController alloc] init];
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:_settingVc];
    
    _situationVc = [[SituationViewController alloc] init];
    UINavigationController *situationNav = [[UINavigationController alloc] initWithRootViewController:_situationVc];
    
    self.viewControllers = @[newNav, newFlashNav, situationNav, personNav];
}


- (void)setupTab {
    [[UITabBar appearance] setBarTintColor:k_white_color];
    [[UITabBar appearance] setTranslucent:NO];
    
    // 取消tabBar的透明效果
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0: {
                obj.tabBarItem.image = [[UIImage imageNamed:@"news_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"new_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title = @"新闻";
            }
                break;
            case 1: {
                obj.tabBarItem.image = [[UIImage imageNamed:@"flash_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"flash_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"快讯";
            }
                break;
            case 2: {
                obj.tabBarItem.image = [[UIImage imageNamed:@"situation_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"situation_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"行情";
            }
                break;
            case 3: {
                obj.tabBarItem.image = [[UIImage imageNamed:@"personal_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"personal_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"我的";
            } break;
            default:
                break;
        }
    }];
    
    //修改文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[k_main_color colorWithAlphaComponent:0.9], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = k_loginmain_color;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end

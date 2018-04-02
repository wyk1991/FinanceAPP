//
//  BaseViewController.h
//  FinaceApp
//
//  Created by SX on 2018/3/2.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *backItem;
/**
 是否禁止返回 默认为NO
 */
@property (nonatomic, getter=isPopEnable) BOOL popEnable;
/**
 是否隐藏返回按钮 默认为NO
 */
@property (nonatomic, getter=isHiddenBackItem) BOOL hiddenBackItem;
/**
 导航栏背景色 默认为主色调
 */
@property (nonatomic, copy) UIColor *navColor;
/**
 导航栏标题颜色 默认为白色
 */
@property (nonatomic, copy) UIColor *titleColor;
/**
 返回按钮颜色 默认为白色
 */
@property (nonatomic, copy) UIColor *backItemColor;
/**
 UI
 */
- (void)initUI;
/**
 返回按钮点击方法
 */
- (void)baseViewControllerBackClick:(UIBarButtonItem *)sender;
/**
 注册通知
 */
- (void)registerNotification;
/**
 移除通知
 */
- (void)removeNotification;
/**
 加载数据
 */
- (void)loadData;
/**
 添加约束
 */
- (void)addMasnory;

@end

//
//  BasePageViewController.h
//  FinaceApp
//
//  Created by SX on 2018/3/4.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "BaseViewController.h"

@interface BasePageViewController : BaseViewController


@property (nonatomic, strong) UIScrollView *categoryScroll;
@property (nonatomic, strong) UIButton *addBtn;

@property(nonatomic,strong)UIScrollView * controllerScroll;

//存放所有文本button的数组
@property(nonatomic,copy)NSMutableArray * button_arr;

/** viewControllView数据源 */
@property (nonatomic, strong) NSMutableArray *viewControllers;

@property (nonatomic, strong) NSMutableArray *titleArr;


- (void)clickAdd;

@end

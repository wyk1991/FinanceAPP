//
//  PushManageViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "PushManageViewController.h"

@interface PushManageViewController ()

@end

@implementation PushManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送管理";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

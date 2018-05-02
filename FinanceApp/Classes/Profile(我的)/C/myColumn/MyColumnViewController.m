//
//  MyColumnViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/5/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "MyColumnViewController.h"

@interface MyColumnViewController ()

@end

@implementation MyColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的专栏";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

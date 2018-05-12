//
//  MyScoreViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/10.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "MyScoreViewController.h"

@interface MyScoreViewController ()

@property (nonatomic, strong) BaseTableView *tableView;

@end

@implementation MyScoreViewController

- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.separatorStyle = 0;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

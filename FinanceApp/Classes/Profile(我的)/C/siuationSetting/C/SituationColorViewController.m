//
//  SituationColorViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationColorViewController.h"
#import "SettingModel.h"
#import "NormalUserCell.h"

@interface SituationColorViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation SituationColorViewController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NormalUserCell class] forCellReuseIdentifier:normalPersonCellIden];
    }
    return _tableView;
}

- (void)initUI {
    [super initUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)loadDataWithType:(SettingType)type {
    NSArray *arr = @[
                     @[
                         @{@"title": @"行情颜色", @"isArrow": @"1", @"isSwitch": @"0"},
                         @{@"title": @"显示价格", @"isArrow": @"1", @"isSwitch": @"0"},
                         @{@"title": @"预警按钮", @"isArrow": @"0", @"isSwitch": @"1"}],
                     @[
                         @{@"title": @"预警提醒", @"isArrow": @"1", @"content": @"声音+震动", @"isSwitch": @"0"},
                         @{@"title": @"已触发预警", @"isArrow": @"1", @"isSwitch": @"0"}
                         ]
                     ];
    self.dataList = [SettingModel mj_objectArrayWithKeyValuesArray:arr];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalUserCell *cell = [tableView dequeueReusableCellWithIdentifier:normalPersonCellIden];
    
    if(!cell) {
        cell = [[NormalUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalPersonCellIden];
    }
    
    cell.model = self. dataList[indexPath.section][indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return CalculateHeight(0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                
            }
                break;
            case 1: {
                
            }
                break;
            case 2: {
                
            }
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                
            }
                break;
            case 1: {
                
            }
                break;
                
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(50);
}

//代理方法 设置分割线的间距
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, CalculateWidth(10), 0, CalculateWidth(10))];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, CalculateWidth(10), 0, CalculateWidth(10))];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSetType:(SettingType *)setType {
    
}

@end

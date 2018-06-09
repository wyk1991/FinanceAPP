//
//  CoinListView.m
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "CoinListView.h"
#import "SituationHelper.h"
#import "CoinListCell.h"
#import "CoinListModel.h"

#import "UpdateCoinListModel.h"

@interface CoinListView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SituationHelper *helper;

@property (nonatomic, strong) NSMutableDictionary *dic;

@property (nonatomic, strong) UpdateCoinListModel *model;
@property (nonatomic, strong) NSMutableArray *selectedArr; // 存放选中项
@property (nonatomic, strong) NSMutableArray *coinNameArr; // 每个大类的coin的存放
@end

@implementation CoinListView

- (NSMutableArray *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = @[].mutableCopy;
    }
    return _selectedArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.tableHeaderView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[CoinListCell class] forCellReuseIdentifier:coinListNameIdentifier];
    }
    return _tableView;
}

- (SituationHelper *)helper {
    if (!_helper) {
        _helper = [SituationHelper shareHelper];
    }
    return _helper;
}

/** init method */
- (instancetype)initWithFrame:(CGRect)frame withCoinDic:(NSDictionary *)dic {
    if (self = [super initWithFrame:frame]) {
        if (_coinName != [dic allKeys][0]) {
            _model = [dic valueForKey:[dic allKeys][0]];
            _model.coin_name = [dic allKeys][0];
            _model.markets = @[].mutableCopy;
        }
        _coinName = [dic allKeys][0];
        self.backgroundColor = k_back_color;
        [self loadDataWithCoinName:_coinName];
        
    }
    return self;
}

- (void)loadDataWithCoinName:(NSString *)name {
    if (!kApplicationDelegate.userHelper.userInfo.token.length) {
        NSLog(@"%@  token", kApplicationDelegate.userHelper.userInfo.token);
        return;
    }
    [self.helper helperGetCoinListNameDataWithPath:situation_listCoinName params:@{@"name":name, @"session_id": kApplicationDelegate.userHelper.userInfo.token} callBack:^(id obj, NSError *error) {
        [self addSubview:self.tableView];
        
        [self.tableView reloadData];
        
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(CalculateHeight(15/2), 0, 0, 0));
    }];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.helper coinNameList].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoinListCell *cell = [tableView dequeueReusableCellWithIdentifier:coinListNameIdentifier];
    
    if(!cell) {
        cell = [[CoinListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coinListNameIdentifier];
    }
    
    cell.model = [[SituationHelper shareHelper] coinNameList][indexPath.row];
    
    return cell;
}


#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CoinListModel *model = [[SituationHelper shareHelper] coinNameList][indexPath.row];
    model.selected = [model.selected isEqualToString:@"1"] ? @"0" : @"1";
    
    if ([model.selected isEqualToString:@"1"]) {
//        [self.selectedArr addObject:@{@"name":model.name}];
//        [self.coinNameArr addObject:@{@"name":model.name}];
        [_model.markets addObject:@{@"name":model.name}];
    } else {
        [_model.markets removeObject:@{@"name":model.name}];
    }
//    [self.selectedArr addObject:@{@"coin_name": self.coinName, @"markets": }];
    NSLog(@"%@", self.selectedArr);
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
}

@end

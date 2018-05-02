//
//  MyCollectionViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/22.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "BaseViewModel.h"
#import "NewsModel.h"
#import "NewsListCell.h"
#import "ArticleWebViewController.h"
@interface MyCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BaseViewModel *helpModel;

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation MyCollectionViewController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (BaseViewModel *)helpModel {
    if (!_helpModel) {
        _helpModel = [[BaseViewModel alloc] init];
        
    }
    return _helpModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [_tableView registerClass:[NewsListCell class] forCellReuseIdentifier:newListIdentifier];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData {
    [self.helpModel startGETRequest:myColleciton inParam:nil outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            self.dataList = [NewsModel mj_keyValuesArrayWithObjectArray:retData[@"articles"]];
        }
    } callback:^(id obj, NSError *error) {
        
    }];
}

#pragma mark - tableview dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newListIdentifier];
    if (!cell) {
        cell = [[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newListIdentifier];
    }
    cell.model = self.dataList[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"跳转webView");
    ArticleWebViewController *vc = [[ArticleWebViewController alloc] initWithUrlString:[self.dataList[indexPath.row] publishedAt]];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

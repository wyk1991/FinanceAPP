//
//  NewFlashListController.m
//  FinanceApp
//
//  Created by SX on 2018/3/31.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "NewFlashListController.h"
#import "FlashHelper.h"
#import "NewFlashListCell.h"
#import "FlashViewModel.h"
#import "FlashModel.h"

#import "DDFlashCache.h"
#import "ShareFlashInfoViewController.h"

static NSString *flashListCellIden = @"flashListCellIden";

@interface NewFlashListController ()<UITableViewDelegate, UITableViewDataSource, ShareBtnClickDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FlashHelper *helper;

@end

@implementation NewFlashListController

- (FlashHelper *)helper {
    if (!_helper) {
        _helper = [FlashHelper shareHelper];
        
    }
    return _helper;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.separatorStyle = 0;
        
        [_tableView registerClass:[NewFlashListCell class] forCellReuseIdentifier:flashListCellIden];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.ts_scrollStatusBar = [TSScrollStatusBar scrollStatusBarWithString:@"111" andIndexY:0];
    
    // 设置加载
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.helper.page = 0;
        [weakSelf refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.helper.page++;
        [weakSelf loadMoreData];
    }];
    
    [self loadData];
    
}

- (void)setCateType:(NSString *)cateType {
    if (_cateType != cateType) {
        _cateType = cateType;
    }
    
    [self refreshData];
    
    // 记录是否有缓存
    if ([[DDFlashCache sharedInstance ] containsObject:cateType] ) {
        return;
    } else {
        [[DDFlashCache sharedInstance] addObject:cateType];
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)refreshData {
    [_helper helperGetFlashListDataWithPath:newFlashList withTags:self.cateType callback:^(id obj, NSError *error) {
        [self.tableView reloadData];
        NSInteger count = [obj[@"kuaixun"] count];
        [self.tableView.ts_scrollStatusBar configWithString:[NSString stringWithFormat:@"+ %ld 篇新内容", count]];
        [self.tableView.ts_scrollStatusBar show];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadMoreData {
    [_helper helperGetFlashListDataWithPath:newFlashList withTags:self.cateType callback:^(id obj, NSError *error) {
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if ([obj[@"kuaixun"] count] == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    [self addMasnory];
}

- (void)loadData {
    [self.tableView.mj_header beginRefreshing];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-CalculateHeight(80));
    }];
}


#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.helper.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.helper.dataList[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewFlashListCell *cell = [tableView dequeueReusableCellWithIdentifier:flashListCellIden];
    if (!cell) {
        cell = [[NewFlashListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flashListCellIden];
    }
    cell.delegate = self;
    cell.viewModel = self.helper.dataList[indexPath.section][indexPath.row];
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlashViewModel *model = self.helper.dataList[indexPath.section][indexPath.row];
    
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (![tableView isEqual:_tableView]) {
        return nil;
    }
    UIView *headerView = nil;
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    headerView.backgroundColor = k_back_color;
    
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.textColor = k_flash_pulish;
    timeLb.font = k_text_font_args(CalculateHeight(15));
    FlashViewModel *viewModel= [self.helper.dataList objectAtIndex:section][0];
    NSString *str = viewModel.model.publishedAt;
    timeLb.text = [NSString stringWithFormat:@"%@年 %@月%@日 ", [str substringToIndex:3], [str substringWithRange:NSMakeRange(5, 2)], [str substringWithRange:NSMakeRange(8, 2)]];
    timeLb.text = viewModel.model.publishedAt;
    timeLb.textAlignment = 1;
    [headerView addSubview:timeLb];
    [timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(15)));
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CalculateHeight(51);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)shareBtnClick:(NewFlashListCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
    FlashViewModel *viewModel = self.helper.dataList[indexPath.section][indexPath.row];
    ShareFlashInfoViewController *vc = [[ShareFlashInfoViewController alloc] init];
    vc.model = viewModel.model;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}


@end

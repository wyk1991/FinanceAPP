//
//  NewFlashListController.m
//  FinanceApp
//
//  Created by SX on 2018/3/31.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "NewFlashListController.h"
#import "FlashHelper.h"

@interface NewFlashListController ()<UITableViewDelegate, UITableViewDataSource>

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
        
        // 设置加载
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.helper.page = 1;
            [weakSelf refreshData];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.helper.page++;
            [weakSelf loadMoreData];
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)refreshData {
    
}

- (void)loadMoreData {
    
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    [self addMasnory];
    
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)loadData {
    [FlashHelper shareHelper] helperGetFlashTagWithPath:<#(NSString *)#> callback:<#^(id obj, NSError *error)callback#>
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

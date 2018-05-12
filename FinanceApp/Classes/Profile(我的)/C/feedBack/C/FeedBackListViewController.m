//
//  FeedBackListViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/10.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "FeedBackListViewController.h"
#import "FeedBackListCell.h"

static NSString *feedBackListIdentifier = @"feedBackListIdentifier";

@interface FeedBackListViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) BaseTableView *tableView;

@end

@implementation FeedBackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈记录";
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.separatorStyle = 0;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[FeedBackListCell class] forCellReuseIdentifier:feedBackListIdentifier];
    }
    return _tableView;
}

- (void)initUI {
    [super initUI];
    self.view.backgroundColor = k_back_color;
    [self.view addSubview:self.tableView];
    
    [self addMasnory];
    [self loadData];
}

- (void)loadData {
    WS(weakSelf);
    [[UserHelper shareHelper] helpFeedBackHistoryWithPath:get_feedBack_history callBack:^(id obj, NSError *error) {
        if (!error && [[[UserHelper shareHelper] feedbackList] count]) {
            [self.tableView reloadData];
        } else {
            [self.tableView showEmptyViewWithType:1];
        }
        
    }];
}



- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[UserHelper shareHelper] feedbackList].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedBackListCell *cell = [tableView dequeueReusableCellWithIdentifier:feedBackListIdentifier];
    
    if(!cell) {
        cell = [[FeedBackListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:feedBackListIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [[UserHelper shareHelper] feedbackList][indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

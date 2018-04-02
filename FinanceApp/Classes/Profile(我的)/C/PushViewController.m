//
//  PushViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "PushViewController.h"
#import "PushCell.h"
#import "SettingModel.h"

static NSString *puchCellIdentifier = @"puchCellIdentifier";

@interface PushViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *tips;
@end

@implementation PushViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送管理";
    [self.view addSubview:self.tableView];
    
    [self addMasnory];
    
}

- (void)loadData {
    if (self.dataArr.count) {
        [self.dataArr removeAllObjects];
    }
    NSMutableArray *arr = @[
                            @[
                            @{@"title": @"接受新消息通知",@"content": @"0"}],
                            
                            @[
                                @{@"title": @"文章消息通知", @"content": @"0"},
                                @{@"title": @"快讯消息通知", @"content": @"0"},
                                @{@"title": @"行情消息通知", @"content": @"0"}
                                ]
                            ];
   self.dataArr  = [SettingModel mj_objectArrayWithKeyValuesArray:arr];
    
    [self.tableView reloadData];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)switchAction:(id)sender {
    UISwitch *swithchBtn = (UISwitch *)sender;
    BOOL isButtonOn = [swithchBtn isOn];
    if (isButtonOn) {
        NSLog(@"开");
    } else {
        NSLog(@"关");
    }
}

#pragma mark - uitableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PushCell *cell = [tableView dequeueReusableCellWithIdentifier:puchCellIdentifier];
    
    if (cell == nil) {
        cell = [[PushCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:puchCellIdentifier];
    }
    cell.model = self.dataArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

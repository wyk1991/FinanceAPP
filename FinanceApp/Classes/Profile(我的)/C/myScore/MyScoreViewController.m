//
//  MyScoreViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/10.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "MyScoreViewController.h"
#import "ScoreListCell.h"

#import "ScoreListModel.h"
#import "NewsModel.h"
#import "NewsListCell.h"

#import "ArticleWebViewController.h"

@interface MyScoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *scoreList;

@property (nonatomic, strong) NSMutableArray *collecionList;

@property (nonatomic, strong) NSString *viewType;
@end

@implementation MyScoreViewController

- (instancetype)initWithViewType:(NSString *)viewType {
    if (self = [super init]) {
        self.viewType = viewType;
        
        
    }
    return self;
}

- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, CalculateWidth(10), 0, CalculateWidth(10));
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[ScoreListCell class] forCellReuseIdentifier:scoreListIdentifier];
        [_tableView registerClass:[NewsListCell class] forCellReuseIdentifier:newListIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)scoreList {
    if (!_scoreList) {
        _scoreList = @[].mutableCopy;
    }
    return _scoreList;
}

- (NSMutableArray *)collecionList {
    if (!_collecionList) {
        _collecionList = @[].mutableCopy;
    }
    return _collecionList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [_viewType isEqualToString:@"0"] ? @"积分": @"我的收藏";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    [self addMasnory];
    [self loadDataWithType:self.viewType];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)loadDataWithType:(NSString *)viewType {
    if ([self.viewType isEqualToString:@"0"]) {
        [HttpTool afnNetworkGetFromPath:get_scoreList and:@{@"session_id": kApplicationDelegate.userHelper.userInfo.token} success:^(id result) {
            if ([result[@"status"] integerValue] == 100) {
                self.scoreList = [ScoreListModel mj_objectArrayWithKeyValuesArray:result[@"coins"]];
                
                [self.tableView reloadData];
            }
        } orFail:^(NSError *error) {
            
        }];
    } else {
        [HttpTool afnNetworkPostParameter:@{@"session_id": kApplicationDelegate.userHelper.userInfo.token} toPath:myColleciton success:^(id result) {
            if ([result[@"status"] integerValue] == 100) {
                self.collecionList =  [NewsModel mj_objectArrayWithKeyValuesArray:result[@"articles"]];
                
                [self.tableView reloadData];
            }
        } orFail:^(NSError *error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewType isEqualToString:@"0"] ? self.scoreList.count : self.collecionList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewType isEqualToString:@"0"] ? CalculateHeight(59) : CalculateHeight(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.viewType isEqualToString:@"0"]) {
        ScoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreListIdentifier];
        
        if(!cell) {
            cell = [[ScoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scoreListIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.scoreList[indexPath.row];
        
        
        return cell;
    } else {
        NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newListIdentifier];
        if (!cell) {
            cell = [[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newListIdentifier];
        }
        cell.selectionStyle = UITableViewRowAnimationNone;
        cell.model = self.collecionList[indexPath.row];
    
        return cell;
    }
}

// 配置侧滑多个按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 实现点击的删除
        NewsModel *model = self.collecionList[indexPath.row];
//        NSDictionary *dic = @{
//                              @"session_id": kApplicationDelegate.userHelper.userInfo.token,
//                              @"coin_name": model.coin_name,
//                              @"markets": model.market
//                              };
//        [self.helper helpDeleteOptionListItemWithPath:situation_optionDelet params:dic callback:^(id obj, NSError *error) {
//            if ([obj[@"status"] integerValue] == 100) {
//                [self.helper.optionsCoinList removeObjectAtIndex:indexPath.row];
//                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
//
//                [self.optionTableView reloadData];
//            }
//        }];
        [self.collecionList removeObject:self.collecionList[indexPath.row]];
    }];
    
    
    
    return @[deleteAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.viewType isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.viewType isEqualToString:@"1"]) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.viewType isEqualToString:@"1"]) {
        NewsModel *model = self.collecionList[indexPath.row];
        
        ArticleWebViewController *vc = [[ArticleWebViewController alloc] initWithUrlString:model.url];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

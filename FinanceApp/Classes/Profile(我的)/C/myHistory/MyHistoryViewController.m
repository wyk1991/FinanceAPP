//
//  MyHistoryViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/24.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "MyHistoryViewController.h"
#import "NewsModel.h"
#import "ArticleWebViewController.h"
#import "NewsListCell.h"

@interface MyHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *historyArr;
@end

@implementation MyHistoryViewController

- (NSMutableArray *)historyArr {
    if (!_historyArr) {
        _historyArr = @[].mutableCopy;
    }
    return _historyArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.separatorStyle = 0;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[NewsListCell class] forCellReuseIdentifier:newListIdentifier];
    }
    return _tableView;
}
- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_back_color;
    [self setupItem];
    [self loadDataFromDisk];
}

- (void)setupItem {
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(112), CalculateHeight(27))];
    img.image = [UIImage imageNamed:@"ic_logo"];
    self.navigationItem.titleView = img;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStyleDone target:self action:@selector(clearHistory)];
}

- (void)loadDataFromDisk {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"plist"];
//    NSArray *arr = [NSMutableArray arrayWithContentsOfFile:path];

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *myPath = [path stringByAppendingPathComponent:historyFile];
    NSArray *arr = [NSMutableArray arrayWithContentsOfFile:myPath];
    for (NSDictionary *dic in arr) {
        NewsModel *model = [NewsModel mj_objectWithKeyValues:dic[@"model"]];
        [self.historyArr addObject:model];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newListIdentifier];
    
    if(!cell) {
        cell = [[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newListIdentifier];
    }
    cell.model = self.historyArr[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.historyArr[indexPath.row];
    ArticleWebViewController *vc = [[ArticleWebViewController alloc] initWithUrlString:model.url];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clearHistory {
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *xiaoXiPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:historyFile];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:xiaoXiPath];
    if (bRet) {
        NSError *err;
        [fileMger removeItemAtPath:xiaoXiPath error:&err];
        [self.historyArr removeAllObjects];
    }
    
    [self.tableView reloadData];
}


@end

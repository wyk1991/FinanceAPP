//
//  SpecialColumnViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/7.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SpecialColumnViewController.h"
#import "MyColumnHeadView.h"
#import "UserHelper.h"
#import "IntroduceMeViewController.h"

@interface SpecialColumnViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UILabel *bottomTip;

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MyColumnHeadView *headView;

@property (nonatomic, strong) UserHelper *helper;

/** html片断 */
@property (nonatomic, strong) NSString *htmlStr;

@end

@implementation SpecialColumnViewController

- (UserHelper *)helper {
    if (!_helper) {
        _helper = [UserHelper shareHelper];
    }
    return _helper;
}

- (MyColumnHeadView *)headView {
    if (!_headView) {
        CGRect rect = CGRectMake(0, 0, kScreenWidth, CalculateHeight(113+64));
        _headView = [[MyColumnHeadView alloc] init];
        _headView.frame = rect;
        _headView.backgroundColor = k_mycolumn_bg;
    }
    return _headView;
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
        
    }
    return _tableView;
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.tableView];
    
    [self addMasnory];
    [self loadData];
}

- (void)addMasnory {
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

// 加载
- (void)loadData {
    [self.helper getTheUserpublishHTMLPath:new_article_content callBack:^(id obj, NSError *error) {
        if ([obj[@"status"] integerValue] == 100) {
            self.htmlStr = obj[@"notes"];
            
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }else{//11系统以下，如果需要还是要加的
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tableView.tableHeaderView = self.headView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar star];
    
    //该页面呈现时手动调用计算导航栏此时应当显示的颜色
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar reset];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.helper.columnList.count ? 2 : 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return section==0 ? 1 : self.helper.columnList.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL1"];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIWebView *webVc = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(220))];
        
        [webVc loadHTMLString:self.htmlStr baseURL:nil];
        
        return webVc;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CalculateHeight(220);
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        // 跳转修改个人介绍
//        IntroduceMeViewController *vc = [[IntroduceMeViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    [self.navigationController.navigationBar changeColor:k_white_color WithScrollView:scrollView AndValue:90];
    if (scrollView.contentOffset.y > 22) {
        self.navigationItem.title = kApplicationDelegate.userHelper.userInfo.user.nickname;
    } else if (scrollView.contentOffset.y < 22 && scrollView.contentOffset.y == 0) {
        self.navigationItem.title = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

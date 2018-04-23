//
//  NewsListViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/6.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsListCell.h"
#import "NewsModel.h"
#import "DDNewsCache.h"
#import "NewPagedFlowView.h"
#import "HomeMiddleView.h"

#import "HomeHelper.h"

#import "SearchViewController.h"
#import "ArticleWebViewController.h"
#import "PGCustomBannerView.h"


@interface NewsListViewController()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UITextFieldDelegate>

//@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) HomeHelper *helper;

@property (nonatomic, strong) NewPagedFlowView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) HomeMiddleView *middleView;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UIView *searchBackView;

@end


@implementation NewsListViewController

- (NewPagedFlowView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_searchBackView.frame) + CalculateHeight(5), kScreenWidth, CalculateHeight(160))];
        _scrollView.delegate = self;
        _scrollView.dataSource = self;
        _scrollView.minimumPageAlpha = 0.1;
        _scrollView.isCarousel = YES;
        _scrollView.orientation = NewPagedFlowViewOrientationHorizontal;
        _scrollView.isOpenAutoScroll = YES;
        
        
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame) + CalculateHeight(10), kScreenWidth, 8)];
        
    }
    return _pageControl;
}

- (HomeMiddleView *)middleView {
    if (!_middleView) {
        _middleView = [[HomeMiddleView alloc] init];
        _middleView.frame = CGRectMake(CalculateWidth(23), CGRectGetMaxY(self.pageControl.frame) + CalculateHeight(10), kScreenWidth - CalculateWidth(23)*2, CalculateHeight(77));
        _middleView.layer.cornerRadius = 5.0f;
        _middleView.layer.masksToBounds = YES;
    }
    return _middleView;
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_backImage"]];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, CalculateHeight(330));
        _headerView.userInteractionEnabled = YES;
    }
    return _headerView;
}

- (UIView *)searchBackView {
    if (!_searchBackView) {
        _searchBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(44))];
        _searchBackView.backgroundColor = [UIColor clearColor];
        
        UITextField *searchTf = [[UITextField alloc] init];
        [searchTf setEnabled:YES];
        searchTf.backgroundColor = k_white_color;
        searchTf.textColor = k_home_search;
        searchTf.placeholder = @"比特币";
        searchTf.font = k_text_font_args(CalculateHeight(14));
        searchTf.delegate = self;
        searchTf.layer.cornerRadius = CalculateWidth(5);
        searchTf.layer.masksToBounds = YES;
        // 创建左侧视图
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
        //        img.frame = CGRectMake(0, 0, CalculateWidth(30), CalculateHeight(30));
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(30), CalculateHeight(30))];
        
        img.center = lv.center;
        [lv addSubview:img];
        searchTf.leftViewMode = UITextFieldViewModeAlways;
        searchTf.leftView = lv;
        
        
        
        [_searchBackView addSubview:searchTf];
        [searchTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(CalculateWidth(35));
            make.right.offset(-CalculateWidth(35));
            make.size.height.equalTo(@(CalculateHeight(30)));
        }];
    }
    return _searchBackView;
}


- (HomeHelper *)helper {
    if (!_helper) {
        _helper = [[HomeHelper alloc] init];
        
    }
    return _helper;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.tableView.ts_scrollStatusBar = [TSScrollStatusBar scrollStatusBarWithString:@"111111" andIndexY:64];;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.headerView addSubview:self.searchBackView];
    [self.headerView addSubview:self.scrollView];
    [self.headerView addSubview:self.pageControl];
    self.scrollView.pageControl = self.pageControl;
}

- (void)setPageType:(NSString *)pageType {
    if (_pageType != pageType) {
        _pageType = pageType;
    }
    // 请求网络数据更新list
    [[HomeHelper shareHelper] helperGetDataListWithPath:newsList WithTag:pageType callBack:^(id obj, NSError *error) {
        
        // 刷新数据
        [self.tableView reloadData];
    }];
    
    // 判断是否滚动图
    if ([pageType isEqualToString:@"toutiao"]) {
        [[HomeHelper shareHelper] helperGetScrollDataWithPath:head_line callBack:^(id obj, NSError *error) {
            if (!error) {
                // 设置滚动的数据源
                [self.scrollView reloadData];
            }
            
        }];
        [[HomeHelper shareHelper] helperGetMiddleData:middleAd callBack:^(id obj, NSError *error) {
            if (!error) {
                // 设置头条数据
                [self.headerView addSubview:self.middleView];
                self.middleView.modelArr = self.helper.contentArr;
            }
            
        }];
        self.tableView.tableHeaderView = self.headerView;
    } else {
        self.tableView.tableHeaderView = self.searchBackView;
        
    }
    
    
    // 记录是否有缓存了
    if ([[DDNewsCache sharedInstance] containsObject:pageType]) {
        return;
    } else {
        [[DDNewsCache sharedInstance] addObject:pageType];
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CalculateHeight(60), 0);
    WS(weakSelf);
    
    // 设置加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.helper.page = 1;
        [weakSelf refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.helper.page++;
        [weakSelf loadMoreData];
    }];
    
    // 去除刷新前的横线
    UIView*view = [UIView new];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackGround)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)refreshData {
    [[HomeHelper shareHelper] helperGetDataListWithPath:newsList WithTag:self.pageType callBack:^(id obj, NSError *error) {
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    [[HomeHelper shareHelper] helperGetDataListWithPath:newsList WithTag:self.pageType callBack:^(id obj, NSError *error) {
        [self.tableView reloadData];
        
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.helper.dateList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newListIdentifier];
    
    if(!cell) {
        cell = [[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newListIdentifier];
    }
    cell.model = self.helper.dateList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CalculateHeight(250);
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"跳转webView");
    ArticleWebViewController *vc = [[ArticleWebViewController alloc] initWithUrlString:[self.helper.dateList[indexPath.row] valueForKey:@"url"]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kScreenWidth - 30, (kScreenWidth - 90) * 9 / 16);
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark - NewPagedFlowView Datasource(设置滚动数据源)
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.helper.scrollList.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
     PGCustomBannerView *bannerView = (PGCustomBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGCustomBannerView alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    // 下载网络图片
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[[self.helper scrollList][index] valueForKey:@"urlToImage"]] placeholderImage:nil];
    bannerView.indexLabel.text = [[self.helper scrollList][index] valueForKey:@"title"];
    
    return bannerView;
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
    
    if (textField == _searchBackView.subviews[0])
        
    {
        
        SearchViewController *seachVc = [[SearchViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:seachVc];
        seachVc.hidesBottomBarWhenPushed = YES;
        [self presentViewController:nav animated:YES completion:nil];
        
    }
    
    
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    [self.searchBackView.subviews[0] resignFirstResponder];
    
}


#pragma mark - enterBackGround
- (void)enterBackGround
{
    [[DDNewsCache sharedInstance] removeAllObjects];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.scrollView stopTimer];
}



@end

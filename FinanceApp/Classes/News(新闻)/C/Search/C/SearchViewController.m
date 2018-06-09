//
//  SearchViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/7.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "SearchViewController.h"
#import "SelectCollectionLayout.h"
#import "SelectCollectionReusableView.h"
#import "CXSearchCollectionViewCell.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"
#import "CXDBHandle.h"

#import "NewsListCell.h"

#import "HomeHelper.h"
#import "RollModel.h"
#import "ArticleWebViewController.h"

static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";


static NSString *newSearchListIdentifier = @"newListIdentifier";
@interface SearchViewController ()
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,

UICollectionViewDelegate,
UICollectionViewDataSource,

SelectCollectionCellDelegate,
UICollectionReusableViewButtonDelegate
>

/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *searchArray;

// 历史记录和热词
@property (nonatomic, strong) UICollectionView *searchCollectionView;

@property (nonatomic, strong) UIView *naviTitle;
@property (nonatomic, strong) UITextField *searchTf;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *line;

/** 搜索分页数 */
@property (nonatomic, assign) NSInteger searchPage;


// 搜索结果的数据
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SearchViewController

-(NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _searchPage = 1;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

#pragma mark - lazy method
- (UIView *)naviTitle {
    if (!_naviTitle) {
        _naviTitle = [[UIView alloc] init];
        _naviTitle.backgroundColor = k_white_color;
        _naviTitle.userInteractionEnabled = YES;
    }
    return _naviTitle;
}

- (UITextField *)searchTf {
    if (!_searchTf) {
        _searchTf = [[UITextField alloc] init];
        _searchTf.placeholder = @"请输入搜索内容";
        _searchTf.layer.cornerRadius = CalculateWidth(5);
        _searchTf.layer.masksToBounds = YES;
        _searchTf.backgroundColor = k_back_color;
        _searchTf.returnKeyType = UIReturnKeySearch;
        _searchTf.font = k_text_font_args(CalculateHeight(14));
        _searchTf.delegate = self;
        _searchTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        // 创建左侧视图
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
//        img.frame = CGRectMake(0, 0, CalculateWidth(30), CalculateHeight(30));
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(30), CalculateHeight(30))];
        
        img.center = lv.center;
        [lv addSubview:img];
        
        _searchTf.leftViewMode = UITextFieldViewModeAlways;
        _searchTf.leftView = lv;
        
        // 添加事件监听
        [_searchTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchTf;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:k_black_color forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = k_text_font_args(CalculateHeight(14));
        
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_back_color;
    }
    return _line;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        // 设置 上拉和下拉刷新控件
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _searchPage = 1;
            [self refreshData];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _searchPage++;
            [self loadMoreData];
        }];
        
        [_tableView registerClass:[NewsListCell class] forCellReuseIdentifier:newSearchListIdentifier];
        
        // 设置tableView 隐藏状态;
        [_tableView setHidden:YES];
    }
    return _tableView;
}

- (void)refreshData {
    if (self.searchTf.text) {
        [self loadDataWithSearchStr:self.searchTf.text];
    }
}

- (void)loadMoreData {
    if (self.searchTf.text) {
        [self loadDataWithSearchStr:self.searchTf.text];
    }
}

- (UICollectionView *)searchCollectionView {
    if (!_searchCollectionView) {
        SelectCollectionLayout *layout = [[SelectCollectionLayout alloc] init];
        
        _searchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _searchCollectionView.backgroundColor = k_white_color;
        _searchCollectionView.delegate = self;
        _searchCollectionView.dataSource = self;
        
        // 注册headerView
        [_searchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
        [_searchCollectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
    }
    return _searchCollectionView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchTf becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.naviTitle];
    [_naviTitle addSubview:self.cancelBtn];
    [_naviTitle addSubview:self.searchTf];
    [_naviTitle addSubview:self.line];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchCollectionView];
    
    [self addMasnory];
    
    [self loadHotWords];
}

- (void)addMasnory {
    [_naviTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.equalTo(@64);
    }];
    [_searchTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.height.equalTo(@(CalculateHeight(32)));
        make.centerY.equalTo(_cancelBtn);
        make.right.equalTo(_cancelBtn.mas_left).offset(-CalculateWidth(12));
    }];
    [_cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(CalculateHeight(20)));
        make.bottom.offset(-CalculateHeight(10));
        make.right.offset(-CalculateWidth(12));
    }];
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.size.height.mas_equalTo(CalculateHeight(1));
    }];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(_naviTitle.mas_bottom);
    }];
    [_searchCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(_naviTitle.mas_bottom);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadHotWords {
    // 查看数据库 是否有历史记录
    NSMutableDictionary *dataDic = @{@"section_id":@"1",@"section_title":@"热搜"}.mutableCopy;
    [[HomeHelper shareHelper] helperGetHotWordsWithPath:hotWrod callBack:^(id obj, NSError *error) {
        if ([obj[@"status"] integerValue] == 100) {
            NSArray *arr = obj[@"hotsearches"];
        
//            [[dataDic valueForKey:@"section_content"] addObject:arr];
            [dataDic addEntriesFromDictionary:@{@"section_content": arr}];
            [self prepareDataWith:dataDic];
            
            [self.searchCollectionView reloadData];
        }
    }];
}

- (void)prepareDataWith:(NSDictionary *)dic {
    NSMutableArray *tmpArr = [@[] mutableCopy];
    
    [tmpArr addObject:dic];
    
    // 查询数据库
    NSDictionary *parmDict = @{@"category": @"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    
    if (dbDictionary.count) {
        [tmpArr addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDict in tmpArr) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchTf becomeFirstResponder];
}

// 搜索请求网络数据
- (void)loadDataWithSearchStr:(NSString *)searchStr{
    NSDictionary *params = @{@"keyword": searchStr, @"start": [NSString stringWithFormat:@"%ld", _searchPage]};
    [[HomeHelper shareHelper] helperGetSearchArticleWithPath:search_Artical params:params callBack:^(id obj, NSError *error) {
        if (!error && [obj[@"status"] integerValue] == 100) {
            NSArray *arr = obj[@"articles"];
            if (_dataList.count && _searchPage == 1) {
                [self.dataList removeAllObjects];
            }
            if (arr.count) {
                for (NSDictionary *dic in arr) {
                    [self.dataList addObject:[RollModel mj_objectWithKeyValues:dic]];
                }
                [self.tableView reloadData];
                if ([self.tableView.mj_header isRefreshing]) {
                    [self.tableView.mj_header endRefreshing];
                }
                if ([self.tableView.mj_footer isRefreshing]) {
                    [self.tableView.mj_footer endRefreshing];
                }
                
            } else {
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }
    }];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CXSearchSectionModel *model = self.sectionArray[section];
    return model.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.word forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SelectCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        CXSearchSectionModel *sectionModel = self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setImage:@"cxCool"];
            view.delectButton.hidden = YES;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = NO;
        }
        
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchSectionModel *sectionModel = self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [CXSearchCollectionViewCell getSizeWithText:contentModel.word];
    }
    return CGSizeMake(80, 24);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate(点击item代理方法)
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell {
    NSIndexPath* indexPath = [self.searchCollectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    NSLog(@"您选的内容是：%@",contentModel.word);
    [self hiddleCollcetion];
    if (self.dataList.count != 0) {
        [self.dataList removeAllObjects];
    }
    self.searchTf.text = contentModel.word;
    [self loadDataWithSearchStr:contentModel.word];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view {
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        [self.searchArray removeAllObjects];
        [self.searchCollectionView reloadData];
        
        // 删除所有数据
        [CXDBHandle saveStatuses:@{} andParam:@{@"category": @"1"}];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTf resignFirstResponder];
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    [self hiddleCollcetion];
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"word"]]) {
        return YES;
    }
    // 请求网络数据
    [self loadDataWithSearchStr:textField.text];
    // 将数据存入到历史记录
    [self saveTextToDB:textField.text];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.searchTf && ![textField.text isEqualToString:@""]) {
        
    } else {
        [self hiddleTableView];
    }
}

- (void)saveTextToDB:(NSString *)textString {
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"word"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [CXDBHandle saveStatuses:searchDict andParam:parmDict];
    
    CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.searchCollectionView reloadData];
//    self.searchTf.text = @"";
}

- (void)hiddleTableView {
    [self.searchCollectionView setHidden:NO];
    [self.tableView setHidden:YES];
}

- (void)hiddleCollcetion {
    [self.searchCollectionView setHidden:YES];
    [self.tableView setHidden:NO];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newSearchListIdentifier];

    if(!cell) {
        cell = [[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newSearchListIdentifier];
    }
    cell.model = self.dataList[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(100);
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转 文章页面
    RollModel *model = self.dataList[indexPath.row];
    ArticleWebViewController *vc = [[ArticleWebViewController alloc] initWithUrlString:model.url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

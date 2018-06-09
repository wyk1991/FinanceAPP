//
//  SituationSearchViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/5/12.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationSearchViewController.h"
#import "CoinListCell.h"
#import "SitutaionResultModel.h"
#import "ArticleWebViewController.h"

@interface SituationSearchViewController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *naviTitle;
@property (nonatomic, strong) UITextField *searchTf;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIView *line;

/** 搜索分页 */
@property (nonatomic, assign) NSUInteger searchPage;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) BaseTableView *tableView;
@end

@implementation SituationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchTf becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.naviTitle];
    [self.naviTitle addSubview:self.cancelBtn];
    [self.naviTitle addSubview:self.searchTf];
    [self.naviTitle addSubview:self.line];
    [self.naviTitle addSubview:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self addMasnory];
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
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (instancetype)init {
    if (self = [super init]) {
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
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView  =[UIView new];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            _searchPage++;
            [self loadMoreData];
        }];
        [_tableView registerClass:[CoinListCell class] forCellReuseIdentifier:coinListNameIdentifier];
        
        [_tableView setHidden:YES];
    }
    return _tableView;
}

- (void)loadMoreData {
    if (self.searchTf.text) {
        [self loadDataWithSearchStr:self.searchTf.text];
    }
}
- (void)loadDataWithSearchStr:(NSString *)searchStr {
    NSDictionary *dic = @{
                          @"name":searchStr,
                          @"start": [NSString stringWithFormat:@"%ld", _searchPage]
                          };
    [HttpTool afnNetworkGetFromPath:situation_search and:dic success:^(id result) {
        if ([result[@"status"] integerValue] == 100) {
            NSArray *arr = result[@"coins"];
            if (_dataList.count) {
                [self.dataList removeAllObjects];
            }
            if (arr.count) {
                [self.tableView removeEmptyView];
                for (NSDictionary *dic in arr) {
                    [self.dataList addObject:[SitutaionResultModel mj_objectWithKeyValues:dic]];
                }
                [self.tableView reloadData];
                if ([self.tableView.mj_footer isRefreshing]) {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else { // 显示搜索无内容的底图
                [self.tableView showEmptyViewWithType:1];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
            }
        }
    } orFail:^(NSError *error) {
        
    }];
}
#pragma mark - uitextfieldDegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    // 请求网络数据
    [self loadDataWithSearchStr:textField.text];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.searchTf && ![textField.text isEqualToString:@""]) {
        [self.dataList removeAllObjects];
        [self.tableView reloadData];
        [self.tableView setHidden:YES];
    } else {
        [self.tableView setHidden:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.searchTf && ![textField.text isEqualToString:@""]) {
        [self.dataList removeAllObjects];
        [self.tableView reloadData];
        [self.tableView setHidden:NO];
    } else {
        [self.tableView setHidden:YES];
    }
}

#pragma mark - uitableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoinListCell *cell = [tableView dequeueReusableCellWithIdentifier:coinListNameIdentifier];
    if (!cell) {
        cell = [[CoinListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coinListNameIdentifier];
    }
    cell.resultModel = self.dataList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

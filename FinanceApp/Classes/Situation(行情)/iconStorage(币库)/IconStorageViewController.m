//
//  IconStorageViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "IconStorageViewController.h"
#import "StorageHeaderView.h"
#import "SituationCell.h"

@interface IconStorageViewController ()<UITableViewDelegate, UITableViewDataSource ,SearchTextClick>

@property (nonatomic, strong) StorageHeaderView *headerView;

@property (nonatomic, strong) UIScrollView *topScrollView;

@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) SituationCell *situationCell;

@property (nonatomic,assign) float cellLastX; //最后的cell的移动距离
@end

@implementation IconStorageViewController


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = k_back_color;
        
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        self.myTableView.tableFooterView = [UIView new];
        self.myTableView.backgroundColor = [UIColor whiteColor];
        self.myTableView.showsHorizontalScrollIndicator = NO;
        self.myTableView.showsVerticalScrollIndicator = NO;
        
        [self.myTableView registerClass:[SituationCell class] forCellReuseIdentifier:situationCellIden];
        
        [self addSubview:self.myTableView];
        
        [self loadData];
    }
    return self;
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] init];
        _topScrollView.showsVerticalScrollIndicator = false;
        _topScrollView.showsHorizontalScrollIndicator = false;
        _topScrollView.backgroundColor = k_white_color;
        
        [_topScrollView setPagingEnabled:YES];
        
        NSArray *titleArr = @[@"价格", @"24H涨幅", @"24H成交额", @"流通市值", @"流通数量", @"流通率", @"发行总量"];
        self.dataArr = [NSMutableArray arrayWithArray:titleArr];
        CGFloat labelW = (kScreenWidth / 2 - CalculateWidth(50))/2;
        
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = [[UILabel alloc] initWithText:titleArr[idx] textColor:k_text_color textFont:k_text_font_args(CalculateHeight(16)) textAlignment:1];
            [_topScrollView addSubview:label];
        }];
        
        _topScrollView.contentSize = CGSizeMake(labelW * titleArr.count, 0);
    }
    return _topScrollView;
}

- (StorageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[StorageHeaderView alloc] initWithFrame:CGRectMake(CalculateHeight(10), 0, kScreenWidth, CalculateHeight(245))];
        _headerView.delegate = self;
        
    }
    return _headerView;
}

- (void)loadData {
    
}

//- (void)setupUI {
//    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
//
//    self.myTableView.dataSource = self;
//    self.myTableView.delegate = self;
//
//
//    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self addSubview:self.myTableView];
//
//    // 注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:tapCellScrollNotification object:nil];
//}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _situationCell = [tableView dequeueReusableCellWithIdentifier:situationCellIden];
    
    if (!_situationCell) {
        _situationCell = [[SituationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:situationCellIden WithArr:self.dataArr type:StroageType];
    }
    _situationCell.tableView = self.myTableView;
    WS(weakSelf);
    _situationCell.tapCellClick = ^(NSIndexPath *indexPath) {
        [weakSelf tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    return _situationCell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(44);
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(40))];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2 - CalculateWidth(50), CalculateHeight(40))];
    back.backgroundColor = RGB(227, 232, 238);
    UILabel *title = [[UILabel alloc] initWithText:@"名称" textColor:k_textgray_color textFont:k_text_font_args(15) textAlignment:0];
    [back addSubview:title];
    [title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(30), CalculateHeight(15)));
    }];
    
    [backView addSubview:back];
    [backView addSubview:self.topScrollView];
    
    [self.headerView addSubview:backView];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CalculateHeight(200);
}

#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.topScrollView]) {
        CGPoint offSet = self.situationCell.rightScrollView.contentOffset;
        offSet.x = scrollView.contentOffset.x;
        self.situationCell.rightScrollView.contentOffset = offSet;
    }
    if ([scrollView isEqual:self.myTableView]) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:tapCellScrollNotification object:self userInfo:@{@"cellOffX":@(self.cellLastX)}];
    }
    
}

-(void)scrollMove:(NSNotification*)notification{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    self.cellLastX = x;
    CGPoint offSet = self.topScrollView.contentOffset;
    offSet.x = x;
    self.topScrollView.contentOffset = offSet;
    obj = nil;
}

- (void)clickSearchTextWithIconType:(NSString *)searchTpye {
    NSLog(@"点击搜索");
}



@end

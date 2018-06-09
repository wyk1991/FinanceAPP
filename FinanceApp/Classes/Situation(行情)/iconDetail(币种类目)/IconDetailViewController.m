//
//  IconDetailViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "IconDetailViewController.h"
#import "SituationCell.h"
#import "RightTableViewCell.h"
#import "MetaDataTool.h"
#import "SituationCell.h"
#import "NormalCoinHeadView.h"
#import "OptionSectionView.h"
#import "OptionCoinModel.h"
#import "OptionDetailCell.h"

#import "Stock.h"
#import "StorageHeaderView.h"
#import "SituationHelper.h"
#import "SituationManager.h"
#import "EarlyWarnViewController.h"
#import "SituationViewController.h"
#import "CoinAllInfoModel.h"
#import "SituationSearchViewController.h"

#import "WYNormalFooter.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

//自定义一个类型，用于表示列表的展开／缩回状态
typedef NS_ENUM(NSUInteger,MCDropdownListSectionStatu) {
    MCDropdownListSectionStatuOpen = 1,
    MCDropdownListSectionStatuClose = 0,
};

static NSString *optionListCellIdentifier = @"optionListCellIdentifier";
@interface IconDetailViewController ()
< UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,
SearchTextClick
>
@property (nonatomic, strong) UIScrollView *topScrollView;

@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) SituationCell *situationCell;

/** 自选顶图 */
@property (nonatomic, strong) UIView *optionTopView;
/** 库币顶图 */
@property (nonatomic, strong) StorageHeaderView *coinTopView;
/** charts顶部图片 */
@property (nonatomic, strong) NormalCoinHeadView *chartsTopView;
@property (nonatomic, strong) UIView *chartsLine;

@property (nonatomic,assign) float cellLastX; //最后的cell的移动距离

@property (nonatomic, strong) SituationHelper *helper;


@property (nonatomic,strong) UIScrollView *buttomScrollView;

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic,strong) NSArray *rightTitles;

@property (nonatomic, strong) NSMutableArray *touchPoints;
/** 记录当前点击的自选的列表 */
@property (nonatomic, assign) NSInteger frontIndex;
@end

@implementation IconDetailViewController

- (NSMutableArray *)touchPoints {
    if (!_touchPoints) {
        _touchPoints = @[].mutableCopy;
    }
    return _touchPoints;
}

#pragma mark - 懒加载属性
- (SituationHelper *)helper {
    if (!_helper) {
        _helper = [SituationHelper shareHelper];
    }
    return _helper;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake((kScreenWidth - CalculateWidth(200))/2, kScreenHeight/2, CalculateWidth(200), CalculateHeight(50));
        [_addBtn setTitle:@"＋添加自选行情" forState:UIControlStateNormal];
        [_addBtn setTitleColor:k_line forState:UIControlStateNormal];
        _addBtn.titleLabel.font = k_text_font_args(CalculateHeight(17));
        _addBtn.backgroundColor = [UIColor clearColor];
        _addBtn.layer.cornerRadius = 10.0f;
        _addBtn.layer.masksToBounds = YES;
        
        _addBtn.layer.borderColor = k_line_color.CGColor;
        _addBtn.layer.borderWidth = CalculateHeight(1);
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(NSArray *)rightTitles{
    if (!_rightTitles) {
        _rightTitles = @[].mutableCopy;
    }
    return _rightTitles;
}

- (StorageHeaderView *)coinTopView {
    if (!_coinTopView) {
        _coinTopView = [[StorageHeaderView alloc] init];
        _coinTopView.frame = CGRectMake(0, CalculateHeight(15/2), kScreenWidth, CalculateHeight(211));
        _coinTopView.delegate = self;

    }
    return _coinTopView;
}

- (NormalCoinHeadView *)chartsTopView {
    if (!_chartsTopView) {
        _chartsTopView = [[NormalCoinHeadView alloc] init];
        _chartsTopView.backgroundColor = [UIColor clearColor];
        _chartsTopView.frame = CGRectMake(0, 0, kScreenWidth, CalculateHeight(264));
        
    }
    return _chartsTopView;
}

- (UIView *)chartsLine {
    if (!_chartsLine) {
        _chartsLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(15/2))];
        _chartsLine.backgroundColor = k_back_color;
    }
    return _chartsLine;
}

- (instancetype)initWithFrame:(CGRect)frame withShowType:(CoinShowType)showType withIndex:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        _showType = showType;
        self.backgroundColor = k_back_color;
        // 请求数据
        [self loadDataWithType:showType index:index];
        if (showType == 0) {
            // 判断当前是否登录
            [self configOptionTableViewWith:showType rightTitles:[SituationManager rightTitleWithType:showType]];
           
            
        } else {
            [self loadScrollerTableWith:showType leftTitles:[SituationManager leftTitleWithType:showType] rightTitles:[SituationManager rightTitleWithType:showType]];
        }
        // 加载头部视图
        [self configViewWith:showType];
        
    }
    return self;
}



- (void)reloadData {
    [self loadDataWithType:self.showType index:self.selectedIndex];
}

- (void)changeTheState {
    [self.optionTableView setHidden:YES];
    [self.addBtn setHidden:NO];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
    }
}

- (void)showAddBtn {
    // 显示添加自选的按钮
    [self.addBtn setHidden:NO];
}

- (void)addBtnClick {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickAddBtn:)]) {
        [_delegate didClickAddBtn:self];
    }
}

- (void)configOptionTableViewWith:(CoinShowType)type rightTitles:(NSArray *)rightTitles {
    if (_rightTitles != rightTitles) {
        _rightTitles = rightTitles;
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(15/2))];
    line.backgroundColor = k_back_color;
    
    self.optionTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(40+15/2))];
    self.optionTopView.backgroundColor = [UIColor clearColor];
    
    UIView *view1 = [self viewWithLeftLabelNumber:1];
    view1.frame = CGRectMake(0, CalculateHeight(15/2), kScreenWidth*7/18, CalculateHeight(40));
    view1.backgroundColor  = RGB(225, 220, 220);
    UIView *view2 = [self viewWithRightLabelNumber:2];
    view2.frame = CGRectMake(kScreenWidth*7/18, CalculateHeight(15/2), kScreenWidth*11/18, CalculateHeight(40));
    int i = 0;
    for (UILabel *label in view2.subviews) {
        label.text = self.rightTitles[i++];
    }
    view2.backgroundColor = RGB(206, 206, 206);
    [self.optionTopView addSubview:view1];
    [self.optionTopView addSubview:view2];
    [self.optionTopView addSubview:line];
    
    
    self.optionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.optionTableView.frame = CGRectMake(0, CalculateHeight(15/2+40), kScreenWidth, kScreenHeight - CalculateHeight(80));
    [self.optionTableView setContentInset:UIEdgeInsetsMake(0, 0, CalculateHeight(150), 0)];
    self.optionTableView.tableFooterView = [UIView new];
    self.optionTableView.delegate = self;
    self.optionTableView.dataSource = self;
    self.optionTableView.showsVerticalScrollIndicator = false;
    self.optionTableView.showsHorizontalScrollIndicator = false;
    [self.optionTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.optionTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.helper.optionPage = 1;
        [self loadMoreData];
    }];
    
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.optionTableView addGestureRecognizer:longPress];
    
    //    [self.optionTableView registerClass:[OptionDetailCell class] forCellReuseIdentifier:optionListCellIdentifier];
    [self.optionTableView registerNib:[UINib nibWithNibName:@"OptionDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:optionListCellIdentifier];
    
    [self addSubview:self.optionTableView];
}

- (void)loadScrollerTableWith:(CoinShowType)type leftTitles:(NSArray *)leftTitles rightTitles:(NSArray *)rightTitles {
    if (_rightTitles != rightTitles) {
        _rightTitles = rightTitles;
    }
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.leftTableView.frame = CGRectMake(0,type == 0 ? CalculateHeight(15/2) :( type == 1 ? CalculateHeight(211+15/2) : CalculateHeight(250+18)), kScreenWidth*7/18, kScreenHeight);
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.leftTableView.backgroundColor = k_back_color;
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.leftTableView registerClass:[SituationCell class] forCellReuseIdentifier:situationCellIden];
    [self.leftTableView.tableFooterView setHidden:YES];
    
    [self addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, type == 0 ? kScreenWidth*11/18: self.rightTitles.count * (self.showType >= 2 ? chartRightLabelWidth : RightLabelWidth) + 20 + RightLabelMagin*(self.rightTitles.count-1), [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor = k_back_color;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightTableView.showsVerticalScrollIndicator = NO;
    [self.rightTableView.tableFooterView setHidden:YES];
    
    // 添加下拉刷新
    if (type == 1) {
        self.leftTableView.mj_footer = [WYNormalFooter footerWithRefreshingBlock:^{
            self.helper.page++;
            [self loadMoreData];
        }];
    }
    
    self.buttomScrollView = [[UIScrollView alloc] init];
    self.buttomScrollView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), type == 0 ? CalculateHeight(15/2) : ( type == 1 ? CalculateHeight(211+15/2) : CalculateHeight(250 + 18)), kScreenWidth*11/18, kScreenHeight);
    self.buttomScrollView.contentSize = CGSizeMake(type == 0 ? kScreenWidth*11/18 : self.rightTableView.bounds.size.width, 0);
    self.buttomScrollView.backgroundColor = [UIColor clearColor];
    self.buttomScrollView.bounces = NO;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.buttomScrollView addSubview:self.rightTableView];
    [self addSubview:self.buttomScrollView];
    
}

#pragma mark - lazy method


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)configViewWith:(CoinShowType)type {
    switch (type) {
        case 0:
            [self addSubview:self.optionTopView];
            [self addSubview:self.addBtn];
            break;
        case 1: {
            [self addSubview:self.coinTopView];
        }
            break;
        case 2: {
            [self addSubview:self.chartsTopView];
            [self.chartsTopView addSubview:self.chartsLine];
        }
            
        default:
            break;
    }
}


- (void)loadDataWithType:(CoinShowType)type index:(NSInteger)index{
    WS(weakSelf);
    switch (type) {
        case 0: {
            NSString *url = [NSString stringWithFormat:@"%@?session_id=%@",situation_optin_list,kApplicationDelegate.userHelper.userInfo.token];
            [weakSelf.helper helperGetOptionCoinListWithPath:url params:@{} callBack:^(id obj, NSError *error) {
                if (!error) {
                    if (self.helper.optionsCoinList.count) {
                        [self.optionTableView setHidden:NO];
                        [self.optionTopView setHidden:NO];
                        [self.addBtn setHidden:YES];
                        [self.optionTableView reloadData];
                    } else {
                        [self.optionTableView setHidden:YES];
                        [self.optionTopView setHidden:YES];
                        [self.addBtn setHidden:NO];
                    }
                    
                }
                if ([obj[@"status"] integerValue] == 204) {
                    [self.optionTableView setHidden:YES];
                    [self.optionTopView setHidden:YES];
                    [self.addBtn setHidden:NO];
                }
            }];
        }
            break;
        case 1: {
            [weakSelf addSubview:self.coinTopView];
            [weakSelf.helper heplerGetStockCoinInfo:situation_coinAllInfo callBack:^(id obj, NSError *error) {
               
                if (!error) {
                    self.coinTopView.dataArr = self.helper.coinInfoData;
                }
            }];
            [weakSelf.helper helperGetListCoinWithPath:situation_listCoin params:@{@"statrt": [NSString stringWithFormat:@"%ld",weakSelf.helper.page]}callBack:^(id obj, NSError *error) {
                if (!error) {
                    [self.leftTableView reloadData];
                    [self.rightTableView reloadData];
                }
            }];
        }
            break;
        case 2:{
            if (self.helper.tagList.count > 2 && index != 0) {
                [weakSelf.helper heplerGetCoinDetailWithPath:situation_coinDetail(_helper.tagList[index]) params:nil callBack:^(id obj, NSError *error) {
                    if (!error) {
                        [self configCoinDetailData];
                        [self.leftTableView reloadData];
                        [self.rightTableView reloadData];
                    }
                }];
            }
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - 加载更多coin列表数据
- (void)loadMoreData {
    if (self.showType == 1) {
        WS(weakSelf);
        [weakSelf.helper helperGetListCoinWithPath:situation_listCoin params:@{@"statrt": [NSString stringWithFormat:@"%ld",weakSelf.helper.page]}callBack:^(id obj, NSError *error) {
            if (!error) {
                if ([obj[@"coins"] count]) {
                    
                    [self.leftTableView reloadData];
                    [self.rightTableView reloadData];
                    [self.leftTableView.mj_footer endRefreshing];
                    [self.rightTableView.mj_footer endRefreshing];
                } else {
                    [self.leftTableView.mj_footer endRefreshing];
                    [self.rightTableView.mj_footer endRefreshing];
                }
            }
        }];
    }
    if (self.showType == 0) {
        WS(weakSelf);
         NSString *url = [NSString stringWithFormat:@"%@?session_id=%@",situation_optin_list,kApplicationDelegate.userHelper.userInfo.token];
        [weakSelf.helper helperGetOptionCoinListWithPath:url params:@{} callBack:^(id obj, NSError *error) {
            if (!error) {
                if ([obj[@"coinlist"] count]) {
                    [self.optionTableView reloadData];
                    [self.optionTopView setHidden:NO];
                    [self.addBtn setHidden:YES];
                    [self.optionTableView setHidden:NO];
                    [self.optionTableView.mj_header endRefreshing];
                } else {
                    [self.optionTableView reloadData];
                    [self.addBtn setHidden:NO];
                    [self.optionTableView setHidden:YES];
                    [self.optionTopView setHidden:YES];
                    [self.optionTableView.mj_header endRefreshing];
                }
            }
        }];
    }
}

- (void)configCoinDetailData {
    [self.chartsTopView setupTheChartStyle:self.helper.chartList withMiddleData:[self.helper.oneDayList firstObject]];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.optionTableView) {
        OptionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:optionListCellIdentifier];
        
        if (!cell) {
            cell = [[OptionDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:optionListCellIdentifier];
        }
        
        cell.model = self.helper.optionsCoinList[indexPath.row];
        cell.tag = indexPath.row;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SpreadImageClick:)];
        [cell addGestureRecognizer:tap];
        
        return cell;
    }
    
    if (tableView == self.leftTableView) {
        SituationCell *cell = [tableView dequeueReusableCellWithIdentifier:situationCellIden];

        if (self.showType == 1) {
            [cell setModel:self.helper.coinListData[indexPath.row] withType:self.showType];
        } else {
            [cell setPriceModel:self.helper.chartCoinList[indexPath.row] withType:self.showType];
        }
        cell.warnBlock = ^{
            if (_delegate && [_delegate respondsToSelector:@selector(didClickWarnImgWith:withInfo:coinName:)]) {
                [_delegate didClickWarnImgWith:self withInfo:self.showType == 1 ? self.helper.coinListData[indexPath.row]   : self.helper.chartCoinList[indexPath.row] coinName:self.showType == 1 ? [(CoinDetailListModel *)self.helper.coinListData[indexPath.row] name]: self.helper.tagList[indexPath.row+2]];
            }
        };
        [self resetSeparatorInsetForCell:cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count];
        if (self.showType == 0) {
//            cell.model = self.helper.optionsCoinList[indexPath.row];
        } else if (self.showType == 1) {
            cell.model = self.helper.coinListData[indexPath.row];
        } else {
            cell.priceModel = self.helper.chartCoinList[indexPath.row];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
//设置cell分割线顶格
- (void)resetSeparatorInsetForCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.showType == 0) {
        return self.helper.optionsCoinList.count;
    }
    return  self.showType == 1 ? self.helper.coinListData.count : self.helper.chartCoinList.count;
}
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.showType == 0) {
    }
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [self viewWithRightLabelNumber:self.rightTitles.count];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
        }
        rightHeaderView.backgroundColor = RGB(206, 206, 206);
        return rightHeaderView;
    }else{
        UIView *leftHeaderView;
        if (self.showType == 1) {
            leftHeaderView = [self viewWithLeftLabelNumber:[SituationManager leftTitleWithType:self.showType].count];
        } else {
            
            leftHeaderView = [self viewWithLeftLabelNumber:1];
        }
        leftHeaderView.backgroundColor = RGB(225, 220, 220);
        return leftHeaderView;
    }
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.leftTableView) {
        [self tableView:self.rightTableView scrollFollowTheOther:self.leftTableView];
    }else{
        [self tableView:self.leftTableView scrollFollowTheOther:self.rightTableView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.showType == 0) {
        return 0;
    }
    return CalculateHeight(40);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showType == 0 ) {
        NSString *cateStr = [self.helper.optionsCoinList[indexPath.row] market];
        MCDropdownListSectionStatu openOrNot = [[self.helper.optionOpenDict valueForKey:cateStr] unsignedIntegerValue];
        if (openOrNot == MCDropdownListSectionStatuOpen) {
            return CalculateHeight(100);
        } else {
            return CalculateHeight(50);
        }
    }
    return CalculateHeight(50);
}


#pragma mark - tableview delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.optionTableView) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.optionTableView) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

// 配置侧滑多个按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
       // 实现点击的删除
        OptionCoinModel *model = self.helper.optionsCoinList[indexPath.row];
        NSDictionary *dic = @{
                              @"session_id": kApplicationDelegate.userHelper.userInfo.token,
                              @"coin_name": model.coin_name,
                              @"markets": model.market
                              };
        [self.helper helpDeleteOptionListItemWithPath:situation_optionDelet params:dic callback:^(id obj, NSError *error) {
            if ([obj[@"status"] integerValue] == 100) {
                [self.helper.optionsCoinList removeObjectAtIndex:indexPath.row];
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                
                [self.optionTableView reloadData];
            }
        }];
    }];
    
    UITableViewRowAction *pushTopAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) {
            return ;
        }
        [self.helper.optionsCoinList exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [self.optionTableView reloadData];
    }];
    pushTopAction.backgroundColor = [UIColor grayColor];
    
    return @[deleteAction, pushTopAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (void)clickSearchTextWithIconType:(NSString *)searchTpye {
    NSLog(@"%@", searchTpye);
    if (_delegate && [_delegate respondsToSelector:@selector(didClickToSeachCoin:)]) {
        [_delegate didClickToSeachCoin:self];
    }
    
}

- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserLoginOutSuccessNotification object:nil];
}

- (void)SpreadImageClick:(UITapGestureRecognizer*)tap{
    //传递当前手势，通过手势识别出点击的cell
    //单元格展开功能
    OptionCoinModel *model =self.helper.optionsCoinList[tap.view.tag];
    NSString *cateStr = model.market;
    MCDropdownListSectionStatu openOrNot = [[self.helper.optionOpenDict objectForKey:cateStr] unsignedIntegerValue];
    
    if (MCDropdownListSectionStatuClose == openOrNot) {
        // 原先缩回的，现在展开
        [self.helper.optionOpenDict setObject:[NSNumber numberWithUnsignedInteger:MCDropdownListSectionStatuOpen] forKey:cateStr];
    } else {
        //原先是展开的，现在缩回
        [self.helper.optionOpenDict setObject:[NSNumber numberWithUnsignedInteger:MCDropdownListSectionStatuClose] forKey:cateStr];
    }
    if (self.frontIndex != tap.view.tag && self.frontIndex >= 0) {
        OptionCoinModel *model =self.helper.optionsCoinList[_frontIndex];
        NSString *cateStr = model.market;
        [self.helper.optionOpenDict setObject:[NSNumber numberWithUnsignedInteger:MCDropdownListSectionStatuClose] forKey:cateStr];
        self.frontIndex = tap.view.tag;
    }
//    [self.optionTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:tap.view.tag inSection:0], [NSIndexPath indexPathForRow:self.frontIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.optionTableView reloadData];
    
}
- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}

- (UIView *)viewWithRightLabelNumber:(NSInteger)num{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.showType >= 2 ? chartRightLabelWidth*num: RightLabelWidth * num, LabelHeight)];
    
    // 计算label的宽度
    NSMutableArray *tmp = @[].mutableCopy;
    for (NSString *str in self.rightTitles) {
        CGFloat value = [str widthWithFont:k_text_font_args(CalculateHeight(16)) height:LabelHeight]+CalculateWidth(2);
        [tmp addObject:[NSString stringWithFormat:@"%f", value]];
    }
    CGFloat tmpf = 0.0;
    for (int i = 0; i < num; i++) {
        if (i!=0) {
            tmpf += [tmp[i-1] floatValue];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i==0 ? CalculateWidth(57)+i*(self.showType >= 2 ? chartRightLabelMargin : RightLabelMagin) :  CalculateWidth(57)+i*(self.showType >= 2 ? chartRightLabelMargin : RightLabelMagin)+ tmpf, 0, CalculateWidth([tmp[i] integerValue] + CalculateWidth(2)), LabelHeight)];
        label.font = k_text_font_args(CalculateHeight(16));
        label.textColor = RGB(168, 168, 168);
        label.tag = i;
        label.textAlignment = 0;
        [view addSubview:label];
    }
    return view;
}

- (UIView *)viewWithLeftLabelNumber:(NSInteger)num {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RightLabelWidth * num, LabelHeight)];
    
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(num==2 ? CalculateWidth(22)+LeftLableMagin*i: CalculateWidth(15), 0, CalculateWidth(40)  , LabelHeight)];
        label.font = k_text_font_args(CalculateHeight(16));
        label.textColor  = k_siuation_unselectTag;
        label.tag = i;
        [label setText:[SituationManager leftTitleWithType:self.showType][i]];
        label.textAlignment = 0;
        [view addSubview:label];
    }
    return view;
}

- (void)fetchData {
    
    [self loadDataWithType:self.showType index:self.selectedIndex];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"scrollView -- %f", scrollView.contentOffset.y);
    if (self.showType == 0) {
        return;
    }
    if (scrollView.contentOffset.y > CalculateHeight(10)) {
        [UIView animateWithDuration:0.5 animations:^{
            if (self.showType == 1) {
                self.coinTopView.st_y = -CalculateHeight(211);
                self.leftTableView.st_y = 0;
                self.buttomScrollView.st_y = 0;
            } else {
                self.chartsTopView.st_y = -CalculateHeight(146+15/2);
                self.leftTableView.st_y = CalculateHeight(116);
                self.buttomScrollView.st_y = CalculateHeight(116);
            }
            
        }];
    } else if(scrollView.contentOffset.y < -CalculateHeight(10)){
        [UIView animateWithDuration:0.5 animations:^{
            if (self.showType == 1) {
                self.coinTopView.st_y = CalculateHeight(15/2);
            } else {
                self.chartsTopView.st_y = 0;
            }
            self.leftTableView.st_y = self.showType == 1 ? CalculateHeight(211+15/2):CalculateHeight(250+18);
            self.buttomScrollView.st_y = self.showType == 1 ? CalculateHeight(211+15/2):CalculateHeight(250+18);
        }];
    }
}

- (void)longPressGestureRecognized:(id)sender {
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    CGPoint location = [longPress locationInView:self.optionTableView];
    NSIndexPath *indexPath = [self.optionTableView indexPathForRowAtPoint:location];
    static UIView *snapshot = nil;
    static NSIndexPath *sourceIndexPath = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:
            //判断是否按在了在cell上
            if (indexPath) {
                sourceIndexPath = indexPath;
                OptionDetailCell *cell = [self.optionTableView cellForRowAtIndexPath:indexPath];
                // 为拖动的cell添加一个快照
                snapshot = [self customSnapshoFromView:cell];
                // 添加快照至tableView中
                __block CGPoint center = cell.center;
                snapshot.alpha = 0.0;
                [self.optionTableView addSubview:snapshot];
                // 按下的瞬间执行动画
                [UIView animateWithDuration:0.25 animations:^{
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                } completion:^(BOOL finished) {
                    cell.hidden = YES;
                }];
            }
            break;
            
            // 移动过程中
        case UIGestureRecognizerStateChanged: {
            // 这里保持数组里面只有最新的两次触摸点的坐标
            [self.touchPoints addObject:[NSValue valueWithCGPoint:location]];
            if (self.touchPoints.count > 2) {
                [self.touchPoints removeObjectAtIndex:0];
            }
            CGPoint center = snapshot.center;
            // 快照随触摸点y值移动（当然也可以根据触摸点的y轴移动量来移动）
            center.y = location.y;
            // 快照随触摸点x值改变量移动
            CGPoint Ppoint = [[self.touchPoints firstObject] CGPointValue];
            CGPoint Npoint = [[self.touchPoints lastObject] CGPointValue];
            CGFloat moveX = Npoint.x - Ppoint.x;
            center.x += moveX;
            snapshot.center = center;
            NSLog(@"%@---%f----%@", self.touchPoints, moveX, NSStringFromCGPoint(center));
            NSLog(@"%@", NSStringFromCGRect(snapshot.frame));
            // 是否移动了
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // 更新数组中的内容
                [self.helper.optionsCoinList exchangeObjectAtIndex:
                 indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // 把cell移动至指定行
                [self.optionTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // 存储改变后indexPath的值，以便下次比较
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default:
            // 清除操作
            // 清空数组，非常重要，不然会发生坐标突变！
            [self.touchPoints removeAllObjects];
            UITableViewCell *cell = [self.optionTableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            // 将快照恢复到初始状态
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];

            break;
    }
}

#pragma mark 创建cell的快照
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    // 用cell的图层生成UIImage，方便一会显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的样子（下面的一些参数可以自己随意设置）
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}



@end

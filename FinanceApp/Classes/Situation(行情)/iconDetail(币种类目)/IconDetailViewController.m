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

#import "Stock.h"
#import "StorageHeaderView.h"
#import "SituationHelper.h"
#import "SituationManager.h"

#define RightLabelWidth CalculateWidth(70)
#define RightLabelMagin CalculateWidth(45)
#define LeftLableMagin CalculateWidth(60)
#define LabelFirstWidth CalculateWidth(9)
#define LabelHeight 40

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface IconDetailViewController ()
< UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,
SearchTextClick
>
@property (nonatomic, strong) UIScrollView *topScrollView;



@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) SituationCell *situationCell;

/** 库币顶图 */
@property (nonatomic, strong) StorageHeaderView *coinTopView;
/** charts顶部图片 */
@property (nonatomic, strong) NormalCoinHeadView *chartsTopView;

@property (nonatomic,assign) float cellLastX; //最后的cell的移动距离

@property (nonatomic, strong) SituationHelper *helper;


@property (nonatomic,strong) UITableView *leftTableView, *rightTableView;
@property (nonatomic,strong) UIScrollView *buttomScrollView;

@property (nonatomic,strong) NSArray *rightTitles;
@property (nonatomic,strong) NSArray *customStocks;
@end

@implementation IconDetailViewController

#pragma mark - 懒加载属性
- (SituationHelper *)helper {
    if (!_helper) {
        _helper = [SituationHelper shareHelper];
    }
    return _helper;
}

- (NSArray *)customStocks{
    if (!_customStocks) {
        _customStocks = [MetaDataTool customStocks];
    }
    return _customStocks;
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
        _chartsTopView.frame = CGRectMake(0, CalculateHeight(15/2), kScreenWidth, CalculateHeight(264));
        
    }
    return _chartsTopView;
}

- (instancetype)initWithFrame:(CGRect)frame withShowType:(CoinShowType)showType withIndex:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        _showType = showType;
        self.backgroundColor = k_back_color;
        // 请求数据
        [self loadDataWithType:showType index:index];
        [self loadScrollerTableWith:showType leftTitles:[SituationManager leftTitleWithType:showType] rightTitles:[SituationManager rightTitleWithType:showType]];
        
        [self configViewWith:showType];
    }
    return self;
}

- (void)loadScrollerTableWith:(CoinShowType)type leftTitles:(NSArray *)leftTitles rightTitles:(NSArray *)rightTitles {
    if (_rightTitles != rightTitles) {
        _rightTitles = rightTitles;
    }
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.leftTableView.frame = CGRectMake(0,type == 0 ? CalculateHeight(15/2) :( type == 1 ? CalculateHeight(211+15/2) : CalculateHeight(250+15)), kScreenWidth*7/18, kScreenHeight);
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.leftTableView.backgroundColor = k_back_color;
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.leftTableView registerClass:[SituationCell class] forCellReuseIdentifier:situationCellIden];
    [self addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, type == 0 ? kScreenWidth*11/18: self.rightTitles.count * RightLabelWidth + 20 + RightLabelMagin*(self.rightTitles.count-1), [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor = k_back_color;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.buttomScrollView = [[UIScrollView alloc] init];
    
    self.buttomScrollView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), type == 0 ? CalculateHeight(15/2) : ( type == 1 ? CalculateHeight(211+15/2) : CalculateHeight(250 + 15)), kScreenWidth*11/18, kScreenHeight);
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
            
            break;
        case 1: {
            [self addSubview:self.coinTopView];
        }
            break;
        case 2: {
            [self addSubview:self.chartsTopView];
        }
            
        default:
            break;
    }
}


- (void)loadDataWithType:(CoinShowType)type index:(NSInteger)index{
    WS(weakSelf);
    switch (type) {
        case 0:
            
            
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

- (void)configCoinDetailData {
    [self.chartsTopView setupTheChartStyle:self.helper.chartList withMiddleData:[self.helper.oneDayList firstObject]];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        SituationCell *cell = [tableView dequeueReusableCellWithIdentifier:situationCellIden];

        if (self.showType == 0) {
            
        } else if (self.showType == 1) {
            [cell setModel:self.helper.coinListData[indexPath.row] withType:self.showType];
        } else {
            [cell setPriceModel:self.helper.oneDayList[indexPath.row] withType:self.showType];
        }
        
        [self resetSeparatorInsetForCell:cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count];
        if (self.showType == 0) {
            
        } else if (self.showType == 1) {
            cell.model = self.helper.coinListData[indexPath.row];
        } else {
            cell.priceModel = self.helper.oneDayList[indexPath.row];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.showType == 0 ? : (self.showType == 1 ? self.helper.coinListData.count : self.helper.oneDayList.count);
}
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [self viewWithRightLabelNumber:self.rightTitles.count];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
        }
        rightHeaderView.backgroundColor = k_siuation_leftHeadBg;
        return rightHeaderView;
    }else{
        UIView *leftHeaderView;
        if (self.showType == 1) {
            leftHeaderView = [self viewWithLeftLabelNumber:[SituationManager leftTitleWithType:self.showType].count];
        } else {
            
            leftHeaderView = [self viewWithLeftLabelNumber:1];
        }
        leftHeaderView.backgroundColor = [UIColor lightGrayColor];
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
    return CalculateHeight(40);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CalculateHeight(50);
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}

- (UIView *)viewWithRightLabelNumber:(NSInteger)num{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RightLabelWidth * num, LabelHeight)];
    
    // 计算label的宽度
    NSMutableArray *tmp = @[].mutableCopy;
    for (NSString *str in self.rightTitles) {
        CGFloat value = [str widthWithFont:k_textB_font_args(CalculateHeight(16)) height:LabelHeight]+CalculateWidth(2);
        [tmp addObject:[NSString stringWithFormat:@"%f", value]];
    }
    CGFloat tmpf = 0.0;
    for (int i = 0; i < num; i++) {
        if (i!=0) {
            tmpf += [tmp[i-1] floatValue];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i==0 ? CalculateWidth(57)+i*RightLabelMagin :  CalculateWidth(57)+i*RightLabelMagin+ tmpf, 0, CalculateWidth([tmp[i] integerValue] + CalculateWidth(2)), LabelHeight)];
        label.font = k_textB_font_args(CalculateHeight(16));
        label.tag = i;
        label.textAlignment = 0;
        [view addSubview:label];
    }
    return view;
}

- (UIView *)viewWithLeftLabelNumber:(NSInteger)num {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RightLabelWidth * num, LabelHeight)];
    
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(num==2 ? CalculateWidth(22)+LeftLableMagin*i: CalculateWidth(50),  0, CalculateWidth(60)  , LabelHeight)];
        label.font = k_textB_font_args(CalculateHeight(16));
        label.tag = i;
        [label setText:[SituationManager leftTitleWithType:self.showType][i]];
        label.textAlignment = 0;
        [view addSubview:label];
    }
    return view;
}



- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"scrollView -- %f", scrollView.contentOffset.y);
    if (self.showType == 0) {
        return;
    }
    if (scrollView.contentOffset.y > CalculateHeight(10)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.coinTopView.st_y = self.showType == 1 ?  -CalculateHeight(211+15/2) : -CalculateHeight(250+15);
            self.leftTableView.st_y = 0;
            self.buttomScrollView.st_y = 0;
        }];
    } else if(scrollView.contentOffset.y < -CalculateHeight(10)){
        [UIView animateWithDuration:0.5 animations:^{
            self.coinTopView.st_y = CalculateHeight(15/2);
            self.leftTableView.st_y = self.showType == 1 ? CalculateHeight(211+15/2):CalculateHeight(250+15);
            self.buttomScrollView.st_y = self.showType == 1 ? CalculateHeight(211+15/2):CalculateHeight(250+15);
        }];
    }
}
@end

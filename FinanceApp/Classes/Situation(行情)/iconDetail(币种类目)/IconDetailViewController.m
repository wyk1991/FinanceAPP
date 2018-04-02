//
//  IconDetailViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "IconDetailViewController.h"
#import "AAChartView.h"
#import "SituationCell.h"
#import "RightTableViewCell.h"
#import "MetaDataTool.h"

#import "Stock.h"

#define LabelWidth 80
#define LabelHeight 40

#define LeftTableViewWidth 100
#define RightLabelWidth 80
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface IconDetailViewController ()<AAChartViewDidFinishLoadDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *topScrollView;

@property (nonatomic, strong) AAChartView *chartView;
@property (nonatomic, strong) AAChartModel *chartModel;

@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) SituationCell *situationCell;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic,assign) float cellLastX; //最后的cell的移动距离



@property (nonatomic,strong) UITableView *leftTableView, *rightTableView;
@property (nonatomic,strong) UIScrollView *buttomScrollView;
@property (nonatomic,strong) NSArray *rightTitles;
@property (nonatomic,strong) NSArray *customStocks;
@end

@implementation IconDetailViewController

#pragma mark - 懒加载属性
- (NSArray *)customStocks{
    if (!_customStocks) {
        _customStocks = [MetaDataTool customStocks];
    }
    return _customStocks;
}

-(NSArray *)rightTitles{
    if (!_rightTitles) {
        _rightTitles = @[@"最新", @"涨幅%", @"涨跌", @"昨收", @"成交量", @"成交额", @"最高", @"最低"];
    }
    return _rightTitles;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadLeftTableView];
        [self loadRightTableView];
    }
    return self;
}

#pragma mark - lazy method
- (AAChartView *)chartView {
    if (!_chartView) {
        _chartView = [[AAChartView alloc] init];
        // 禁用滚动
        _chartView.scrollEnabled = NO;
        _chartView.isClearBackgroundColor = YES;
        
        
        // 设置数据样式
        self.chartModel = AAObject(AAChartModel)
        .chartTypeSet(AAChartTypeAreaspline)
        .titleSet(@"")
        .subtitleSet(@"")
        .colorsThemeSet(@[@"#fe117c"])//设置主体颜色数组
        .yAxisTitleSet(@"")//设置 Y 轴标题
        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
        .backgroundColorSet(@"#4b2b7f")
        .yAxisGridLineWidthSet(@1)//y轴横向分割线宽度为0(即是隐藏分割线)
        .seriesSet(@[
                     ]);
        // 设置弹性动画
        self.chartModel.animationType = AAChartAnimationEaseOutQuart;
        //启用渐变色
        self.chartModel.gradientColorEnabled = true;
        self.chartModel.stacking = AAChartStackingTypeFalse;
        self.chartModel.symbol = AAChartSymbolTypeCircle;
        self.chartModel.markerRadius = @0;
        
        // chartView 和 model 建立联系
        [_chartView aa_drawChartWithChartModel:self.chartModel];
        
        
        _chartView.delegate = self;
    }
    return _chartView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)loadLeftTableView{
    //    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LeftTableViewWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self);
        make.width.equalTo(@(LeftTableViewWidth));
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.rightTitles.count * RightLabelWidth + 20, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    
    //    self.buttomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(LeftTableViewWidth, 0, [UIScreen mainScreen].bounds.size.width - LeftTableViewWidth, [UIScreen mainScreen].bounds.size.height)];
    self.buttomScrollView = [[UIScrollView alloc] init];
    
    self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
    self.buttomScrollView.backgroundColor = [UIColor redColor];
    self.buttomScrollView.bounces = NO;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.buttomScrollView addSubview:self.rightTableView];
    [self addSubview:self.buttomScrollView];
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(self);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
    
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
        }
        Stock *stock = self.customStocks[indexPath.row % 7];
        cell.detailTextLabel.text = @"1";
        cell.textLabel.text = @"12";
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text = [NSString stringWithFormat:@"%ld", indexPath.row];
        }
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
    return 100;
}
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [self viewWithLabelNumber:self.rightTitles.count];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
        }
        rightHeaderView.backgroundColor = [UIColor lightGrayColor];
        return rightHeaderView;
    }else{
        UIView *leftHeaderView = [self viewWithLabelNumber:1];
        [leftHeaderView.subviews.lastObject setText:@"自选股票"];
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

- (UIView *)viewWithLabelNumber:(NSInteger)num{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LabelWidth * num, LabelHeight)];
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LabelWidth * i, 0, LabelWidth, LabelHeight)];
        label.tag = i;
        label.textAlignment = NSTextAlignmentRight;
        [view addSubview:label];
    }
    return view;
}

//- (void)initUI {
//    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CalculateHeight(200), kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//
//    self.myTableView.dataSource = self;
//    self.myTableView.delegate = self;
//
//    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    // 注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:tapCellScrollNotification object:nil];
//
//    [self addSubview:self.myTableView];
//    [self addSubview:self.chartView];
//
//}
//
//- (void)loadData {
//
//}
//
//
//#pragma mark - UITableView Datasource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    _situationCell = [tableView dequeueReusableCellWithIdentifier:situationCellIden];
//
//    if (!_situationCell) {
//        _situationCell = [[SituationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:situationCellIden WithArr:self.dataArr type:NormalType];
//    }
//    _situationCell.tableView = self.myTableView;
//    WS(weakSelf);
//    _situationCell.tapCellClick = ^(NSIndexPath *indexPath) {
//        [weakSelf tableView:tableView didSelectRowAtIndexPath:indexPath];
//    };
//    return _situationCell;
//}
//
//#pragma mark - UITableView Delegate methods
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return CalculateHeight(44);
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return CalculateHeight(40);
//}
//
//// 刷新图表信息
//- (void)setupThChartView {
//    [self.chartView aa_refreshChartWithChartModel:self.chartModel];
//}
//
//- (void)AAChartViewDidFinishLoad {
//    NSLog(@"图表数据加载完毕");
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGFloat labelW = (kScreenWidth / 2 - CalculateWidth(50))/2;
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3000, CalculateHeight(40))];
//    backView.backgroundColor = [UIColor clearColor];
//
//    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2 - CalculateWidth(50), CalculateHeight(40))];
//    back.backgroundColor = RGB(227, 232, 238);
//    UILabel *title = [[UILabel alloc] initWithText:@"名称" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(15)) textAlignment:1];
//    [back addSubview:title];
//    [title mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(k_leftMargin);
//        make.centerY.offset(0);
//        make.size.mas_equalTo(CGSizeMake(CalculateWidth(10), CalculateHeight(15)));
//    }];
//
//
//    NSArray *titleArr = @[@"最新价", @"涨幅", @"24小时成交量", @"24小时最高", @"24小时最低"];
//    self.dataArr = [NSMutableArray arrayWithArray:titleArr];
//
//    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - CalculateWidth(50), 0, labelW * titleArr.count, CalculateHeight(40))];
//    self.topScrollView.showsVerticalScrollIndicator = NO;
//    self.topScrollView.showsHorizontalScrollIndicator = NO;
//    self.topScrollView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
//
//
//    [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UILabel *label = [[UILabel alloc] initWithText:titleArr[idx] textColor:k_text_color textFont:k_text_font_args(CalculateHeight(16)) textAlignment:0];
//        label.frame = CGRectMake(labelW*idx, 0, labelW, CalculateHeight(CalculateHeight(40)));
//        [self.topScrollView addSubview:label];
//    }];
//
//    self.topScrollView.delegate = self;
//    self.topScrollView.contentSize = CGSizeMake(labelW * titleArr.count, 0);
//
//
//
//    [backView addSubview:back];
//    [backView addSubview:self.topScrollView];
//
//    return backView;
//}
//
//
//#pragma mark-- UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if ([scrollView isEqual:self.topScrollView]) {
//        CGPoint offSet = self.situationCell.rightScrollView.contentOffset;
//        offSet.x = scrollView.contentOffset.x;
//        self.situationCell.rightScrollView.contentOffset = offSet;
//    }
//    if ([scrollView isEqual:self.myTableView]) {
//        // 发送通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:tapCellScrollNotification object:self userInfo:@{@"cellOffX":@(self.cellLastX)}];
//    }
//
//}
//
//-(void)scrollMove:(NSNotification*)notification{
//    NSDictionary *noticeInfo = notification.userInfo;
//    NSObject *obj = notification.object;
//    float x = [noticeInfo[@"cellOffX"] floatValue];
//    self.cellLastX = x;
//    CGPoint offSet = self.topScrollView.contentOffset;
//    offSet.x = x;
//    self.topScrollView.contentOffset = offSet;
//    obj = nil;
//}



@end

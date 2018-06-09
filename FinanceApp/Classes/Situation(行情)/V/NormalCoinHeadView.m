//
//  NormalCoinHeadView.m
//  FinanceApp
//
//  Created by SX on 2018/4/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "NormalCoinHeadView.h"
#import "AAChartView.h"
#import "HeadMiddleView.h"
@interface NormalCoinHeadView()<AAChartViewDidFinishLoadDelegate>


@property (nonatomic, strong) HeadMiddleView *middleView;

@property (nonatomic, strong) UIView *line;
@end

@implementation NormalCoinHeadView

- (AAChartView *)chartView {
    if (!_chartView) {
        _chartView = [[AAChartView alloc] initWithFrame:CGRectZero];
        _chartView.isClearBackgroundColor = YES;
        _chartView.backgroundColor = k_white_color;
        _chartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
        
        _chartView.delegate = self;
    }
    return _chartView;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_back_color;
    }
    return _line;
}

- (HeadMiddleView *)middleView {
    if (!_middleView) {
        _middleView = [[HeadMiddleView alloc] init];
    }
    return _middleView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_chartView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(15/2));
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(150)));
    }];
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_chartView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(15/2)));
    }];
    [_middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(104)));
    }];
}

- (void)setupTheChartStyle:(NSArray *)chartData withMiddleData:(PricesModel *)priceModel{
    
    NSNumber *maxValue = [[chartData[0] objectForKey:@"cny"] valueForKeyPath:@"@max.floatValue"];
    NSNumber *minValue = [[chartData[0] objectForKey:@"cny"] valueForKeyPath:@"@min.floatValue"];
    
    double middle = [maxValue doubleValue] - [minValue doubleValue];
    NSInteger value = middle / 10;
    
    NSInteger middleValue = ([maxValue integerValue] + value )- ([minValue integerValue] - value);
    
    NSInteger integerValue = middleValue / 3;
    
    NSArray *arr = @[[NSNumber numberWithDouble:[minValue integerValue] - value ],
                     [NSNumber numberWithDouble:[minValue integerValue] - value + integerValue ],
                     [NSNumber numberWithDouble:[minValue integerValue] - value + 2*integerValue ],
                     [NSNumber numberWithDouble:[minValue integerValue] - value +  3*integerValue]];
    
    
    self.chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeAreaspline)//图表类型
    .titleFontSizeSet(@0)
    .yAxisCrosshairWidthSet(@0.8)
    .yAxisTickPositionsSet(arr)
    .subtitleFontSizeSet(@0)
    .yAxisLabelsEnabledSet(true)
    .yAxisVisibleSet(true)//设置 Y 轴是否可见
    .xAxisLabelsEnabledSet(YES)
    .colorsThemeSet(@[@"#399bdb"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
    //        .tooltipValueSuffixSet(@"$")//设置浮动提示框单位后缀
    .legendEnabledSet(NO)
    .backgroundColorSet(@"#399bdb")
    .yAxisGridLineWidthSet(@0.5)//y轴横向分割线宽度为0(即是隐藏分割线)
    ;
    
//    self.chartModel.symbolStyle = AAChartSymbolStyleTypeInnerBlank;//设置折线连接点样式为:内部白色
//    self.chartModel.gradientColorEnabled = true;//启用渐变色
//    self.chartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为弹性动画
//    // 用户设置的数值
////    NSString *unitMonery = [kNSUserDefaults objectForKey:user_currency];
//    self.chartModel.series = @[
//                               AAObject(AASeriesElement)
//                               .nameSet(@"")
//                               .dataSet([chartData[0] objectForKey:@"cny"] )
//                               ];
//
//    [self.chartView aa_drawChartWithChartModel:self.chartModel];
    
    
    
    //启用渐变色
//    self.chartModel.gradientColorEnabled = true;
//    self.chartModel.symbol = AAChartSymbolTypeCircle;
    self.chartModel.markerRadius = @0;
    self.chartModel.xAxisTickInterval = [NSNumber numberWithInteger:2];
    self.chartModel.categories = [chartData[2] objectForKey:@"time"];
    self.chartModel.yAxisGridLineWidth = @0.5;
    self.chartModel.yAxisMin = 0;
//    self.chartModel.gradientColorEnabled = true;//启用渐变色
//    self.chartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为弹性动画
    self.chartModel.series =@[
                              AAObject(AASeriesElement)
                              .nameSet(@"$")
                              .dataSet([chartData[0] objectForKey:@"cny"])
                              .fillOpacitySet(@0.2)
                              ];
    
    [self.chartView aa_drawChartWithChartModel:self.chartModel];
    
    // 设置中间图标数据
    self.middleView.model = priceModel;
}

- (void)setupUI {
    self.backgroundColor = k_back_color;
    [self addSubview:self.chartView];
    [self addSubview:self.line];
    [self addSubview:self.middleView];
    
    self.chartView.chartSeriesHidden = YES;
}

// 刷新图表信息
- (void)setupThChartView {
    [self.chartView aa_refreshChartWithChartModel:self.chartModel];
}

- (void)AAChartViewDidFinishLoad {
    NSLog(@"图表数据加载完毕");
}

@end

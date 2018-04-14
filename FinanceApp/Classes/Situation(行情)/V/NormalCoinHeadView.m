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

@property (nonatomic, strong) AAChartView *chartView;
@property (nonatomic, strong) AAChartModel *chartModel;

@property (nonatomic, strong) HeadMiddleView *middleView;
@end

@implementation NormalCoinHeadView

- (AAChartView *)chartView {
    if (!_chartView) {
        _chartView = [[AAChartView alloc] initWithFrame:CGRectZero];
//        // 禁用滚动
//        _chartView.scrollEnabled = NO;
        _chartView.isClearBackgroundColor = YES;
        _chartView.backgroundColor = k_white_color;
//
//
//        // 设置数据样式
//        self.chartModel = AAObject(AAChartModel)
//        .chartTypeSet(AAChartTypeAreaspline)
//        .titleSet(@"")
//        .subtitleSet(@"")
//        .yAxisVisibleSet(true)
//        .colorsThemeSet(@[@"#fe117c"])//设置主体颜色数组
//        .yAxisTitleSet(@"")//设置 Y 轴标题
//        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
//        .backgroundColorSet(@"#4b2b7f")
//        .yAxisGridLineWidthSet(@1)//y轴横向分割线宽度为0(即是隐藏分割线)
//        .seriesSet(@[
//                     AAObject(AASeriesElement)
//                     .nameSet(@"")
//                     .dataSet(@[@7000, @6009, @9005, @1405, @1802, @2105, @2592, @2695, @2399, @1893])
//                     ]);
//        // 设置弹性动画
        
//
//        // chartView 和 model 建立联系
//        [_chartView aa_drawChartWithChartModel:self.chartModel];
        _chartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
        //    设置aaChartVie 的内容高度(content height)
//            self.chartView.contentHeight = CalculateHeight(150);
        
        self.chartModel= AAObject(AAChartModel)
        .chartTypeSet(AAChartTypeAreaspline)//图表类型
        .yAxisMinSet(@4000)
        .yAxisMinSet(@4800)
        .titleSet(@"")//图表主标题
        .subtitleSet(@"")//图表副标题
        .yAxisLabelsEnabledSet(true)
        .yAxisVisibleSet(true)//设置 Y 轴是否可见
        .colorsThemeSet(@[@"#fe117c"])//设置主体颜色数组
        .yAxisTitleSet(@"")//设置 Y 轴标题
        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
        .backgroundColorSet(@"#4b2b7f")
        .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
        .seriesSet(@[
                     AAObject(AASeriesElement)
                     .nameSet(@"")
                     .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6])
                     ]
                   );
        
        _chartView.delegate = self;
    }
    return _chartView;
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
        make.top.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(150)));
    }];
    [_middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chartView.mas_bottom).offset(CalculateHeight(15/2));
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(104)));
    }];
}

- (void)setupTheChartStyle:(NSArray *)chartData {
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
    
    NSNumber *maxValue = [[chartData[0] objectForKey:@"cny"] valueForKeyPath:@"@max.floatValue"];
    NSNumber *minValue = [[chartData[0] objectForKey:@"cny"] valueForKeyPath:@"@min.floatValue"];
    
    self.chartModel.animationType = AAChartAnimationEaseOutQuart;
    //启用渐变色
    self.chartModel.gradientColorEnabled = true;
    self.chartModel.stacking = AAChartStackingTypeFalse;
    self.chartModel.symbol = AAChartSymbolTypeCircle;
    self.chartModel.markerRadius = @0;
    
    self.chartModel.categories = [chartData[2] objectForKey:@"time"];
    self.chartModel.gradientColorEnabled = true;//启用渐变色
    self.chartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为弹性动画
    self.chartModel.series =@[
                              AAObject(AASeriesElement)
                              .nameSet(@"")
                              .fillOpacitySet(@0.3)
                              .dataSet([chartData[0] objectForKey:@"cny"])
                              
                              ];
    
    [self.chartView aa_drawChartWithChartModel:self.chartModel];
}

- (void)setupUI {
    self.backgroundColor = k_white_color;
    [self addSubview:self.chartView];
    [self addSubview:self.middleView];
}


// 刷新图表信息
- (void)setupThChartView {
    [self.chartView aa_refreshChartWithChartModel:self.chartModel];
}

- (void)AAChartViewDidFinishLoad {
    NSLog(@"图表数据加载完毕");
}

@end

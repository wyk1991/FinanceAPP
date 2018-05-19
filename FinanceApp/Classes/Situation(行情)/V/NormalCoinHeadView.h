//
//  NormalCoinHeadView.h
//  FinanceApp
//
//  Created by SX on 2018/4/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"
#import "AAChartView.h"
@class ChartsDetailModel, PricesModel;
@interface NormalCoinHeadView : BaseView

@property (nonatomic, strong) AAChartView *chartView;

@property (nonatomic, strong) AAChartModel *chartModel;
- (void)setupTheChartStyle:(NSArray *)chartData withMiddleData:(PricesModel *)priceModel;
@end

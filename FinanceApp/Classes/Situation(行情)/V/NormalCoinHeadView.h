//
//  NormalCoinHeadView.h
//  FinanceApp
//
//  Created by SX on 2018/4/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"
@class ChartsDetailModel, PricesModel;
@interface NormalCoinHeadView : BaseView

- (void)setupTheChartStyle:(NSArray *)chartData withMiddleData:(PricesModel *)priceModel;
@end

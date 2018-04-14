//
//  IconDetailViewController.h
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

typedef enum : NSUInteger {
    OptionCoinType,
    StroageCoinType,
    ChartsCoinType,
} CoinShowType;

#import "BaseView.h"


@interface IconDetailViewController : BaseView

- (void)fetchData;

@property (nonatomic, assign) CoinShowType showType;

- (instancetype)initWithFrame:(CGRect)frame withShowType:(CoinShowType)showType withIndex:(NSInteger)index;

@end

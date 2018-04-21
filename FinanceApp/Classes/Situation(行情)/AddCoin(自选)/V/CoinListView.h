//
//  CoinListView.h
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

@interface CoinListView : BaseView

@property (nonatomic, strong) NSString *coinName;

- (instancetype)initWithFrame:(CGRect)frame WithCoinName:(NSString *)name;

@end

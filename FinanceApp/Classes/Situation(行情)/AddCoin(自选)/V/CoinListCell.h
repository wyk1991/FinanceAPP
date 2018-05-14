//
//  CoinListCell.h
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseCell.h"

static NSString *coinListNameIdentifier = @"coinListNameIdentifier";
@class CoinListModel, SitutaionResultModel;
@interface CoinListCell : BaseCell


@property (nonatomic, strong) CoinListModel *model;

@property (nonatomic, strong) SitutaionResultModel *resultModel;
@end

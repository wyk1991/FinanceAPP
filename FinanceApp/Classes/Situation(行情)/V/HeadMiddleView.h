//
//  HeadMiddleView.h
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"
@class ChartsDetailModel, PricesModel;
typedef void (^ClickNoticeImg)(NSString *iconType);

@interface HeadMiddleView : BaseView

@property (nonatomic, copy) ClickNoticeImg block;
@property (nonatomic, strong)PricesModel *model;

@end

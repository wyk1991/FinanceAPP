//
//  EarlyWarnViewController.h
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewController.h"

@class PricesModel;
@interface EarlyWarnViewController : BaseViewController

@property (nonatomic, strong) PricesModel *model;
@property (nonatomic, strong) NSString*coinName;

@end

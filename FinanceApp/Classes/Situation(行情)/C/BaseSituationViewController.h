//
//  BaseSituationViewController.h
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewController.h"

@class SituationCell;
@interface BaseSituationViewController : BaseViewController

@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) SituationCell *situationCell;

@property (nonatomic,assign) float cellLastX; //最后的cell的移动距离

@end

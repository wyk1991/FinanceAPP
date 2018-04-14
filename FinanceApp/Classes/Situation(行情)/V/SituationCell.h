//
//  SituationCell.h
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseCell.h"
#import "IconDetailViewController.h"
static NSString *situationCellIden = @"situationCellIden";
typedef void(^TapCellClick)(NSIndexPath *indexPath);

@class CoinDetailListModel, ChartsDetailModel, PricesModel;
@interface SituationCell : BaseCell

@property (nonatomic, strong) UIImageView *augurImg;
@property (strong, nonatomic) UILabel *categoryLb;
@property (nonatomic, strong) UILabel *nameLb;
@property (strong, nonatomic) UIScrollView *rightScrollView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isNotification;
@property (nonatomic, copy) TapCellClick tapCellClick;

@property (nonatomic, assign) CoinShowType leftType;

@property (nonatomic, strong) PricesModel *priceModel;
@property (nonatomic, strong) CoinDetailListModel *model;
- (void)setModel:(CoinDetailListModel *)model withType:(CoinShowType)type;


@end

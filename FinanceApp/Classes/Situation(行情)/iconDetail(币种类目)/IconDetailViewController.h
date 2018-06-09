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

@class IconDetailViewController, PricesModel;
@protocol  WarnCellImgActionDelegate <NSObject>

- (void)didClickWarnImgWith:(IconDetailViewController *)subView withInfo:(PricesModel *)model coinName:(NSString *)coinName;
- (void)didClickToSeachCoin:(IconDetailViewController *)subView;

- (void)didClickAddBtn:(IconDetailViewController *)subView;
@end

#import "BaseView.h"


@interface IconDetailViewController : BaseView

- (void)fetchData;

@property (nonatomic, assign) CoinShowType showType;

@property (nonatomic, assign) id<WarnCellImgActionDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic,strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) UITableView *optionTableView;
- (instancetype)initWithFrame:(CGRect)frame withShowType:(CoinShowType)showType withIndex:(NSInteger)index;

@end

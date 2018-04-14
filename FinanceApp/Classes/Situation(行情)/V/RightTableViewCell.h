//
//  RightTableViewCell.h
//  doubleTableView
//
//  Created by tarena13 on 15/10/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoinDetailListModel, ChartsDetailModel, PricesModel;
@interface RightTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number;


@property (nonatomic, strong) CoinDetailListModel *model;

@property (nonatomic, strong) PricesModel *priceModel;
@end

//
//  OptionDetailCell.h
//  FinanceApp
//
//  Created by SX on 2018/4/19.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OptionCoinModel;
@interface OptionDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *turnoverLb;
@property (weak, nonatomic) IBOutlet UILabel *maxPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *minPrice;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *categoryLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property (nonatomic, strong) OptionCoinModel *model;
@end

//
//  WarnPriceCell.h
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *warinPriceCellIdentifier = @"warinPriceCellIdentifier";
@class PricesModel;
@interface WarnPriceCell : UITableViewCell
@property (nonatomic, strong) PricesModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *cnyPrice;
@property (weak, nonatomic) IBOutlet UILabel *usdPrice;

@end

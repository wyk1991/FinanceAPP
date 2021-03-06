//
//  OptionDetailCell.m
//  FinanceApp
//
//  Created by SX on 2018/4/19.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "OptionDetailCell.h"
#import "OptionCoinModel.h"
@implementation OptionDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(OptionCoinModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.turnoverLb.text = model.oneday_amount;
    self.maxPriceLb.text = [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? [NSString stringWithFormat:@"$%@", model.oneday_highest_cny]  : [NSString stringWithFormat:@"$%@", model.oneday_highest_usd];
    self.minPrice.text = [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? [NSString stringWithFormat:@"￥%@", model.oneday_lowest_cny]  : [NSString stringWithFormat:@"$%@", model.oneday_lowest_usd];
    
    
    self.nameLb.text = model.coin_name;
    self.categoryLb.text = model.market;
    self.priceLb.text = [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? [NSString stringWithFormat:@"￥%@ $%@", model.oneday_highest_cny, model.oneday_highest_usd] : [NSString stringWithFormat:@"$%@ ￥%@", model.oneday_highest_usd, model.oneday_highest_cny];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

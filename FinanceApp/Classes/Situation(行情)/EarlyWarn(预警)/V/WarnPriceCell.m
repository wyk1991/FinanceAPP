//
//  WarnPriceCell.m
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "WarnPriceCell.h"
#import "ChartsDetailModel.h"

@implementation WarnPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PricesModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.nameLb.text = model.trading_market_name;
    self.cnyPrice.text = [NSString stringWithFormat:@"￥ %@",model.price_cny];
    self.usdPrice.text = [NSString stringWithFormat:@"$ %@", model.price_usd];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

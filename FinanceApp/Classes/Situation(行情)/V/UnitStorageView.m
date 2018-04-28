//
//  UnitStorageView.m
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UnitStorageView.h"
#import "UnitInfoModel.h"
@interface UnitStorageView()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *count;
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation UnitStorageView

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        
    }
    return _iconImg;
}

- (UILabel *)count {
    if (!_count) {
        _count = [[UILabel alloc] initWithText:@"123" textColor:k_siuation_count textFont:k_text_font_args(CalculateHeight(17)) textAlignment:0];
    }
    return _count;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithText:@"大度阿达" textColor:k_siutaion_title textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    }
    return _titleLb;
}

- (void)setupUI {
    [self addSubview:self.iconImg];
    [self addSubview:self.count];
    [self addSubview:self.titleLb];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(24));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(40), CalculateHeight(40)));
    }];
    [_count mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(10));
        make.top.offset(CalculateHeight(15));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_count);
        make.top.equalTo(_count.mas_bottom).offset(CalculateHeight(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
}

- (void)setModel:(UnitInfoModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.iconImg.image = [UIImage imageNamed:model.icon_img];
    self.count.text = [model.title isEqualToString:@"流通总市值"] || [model.title isEqualToString:@"24H交易额"] ?  [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? [NSString stringWithFormat:@"￥%@",model.coin_count] : [NSString stringWithFormat:@"$%@", model.coin_count] : model.coin_count ;
    self.titleLb.text = model.title;
}


@end

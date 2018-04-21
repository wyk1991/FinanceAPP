//
//  OptionSectionView.m
//  FinanceApp
//
//  Created by SX on 2018/4/20.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "OptionSectionView.h"
#import "OptionCoinModel.h"
@interface OptionSectionView()

@property (nonatomic, strong) UIImageView *augurImg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *categoryLb;

@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *raseLb;

@end

@implementation OptionSectionView
- (UIImageView *)augurImg {
    if (!_augurImg) {
        _augurImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_hangqing_lingdang"]];
        
    }
    return _augurImg;
}


- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:@"111" textColor:k_black_color textFont:k_text_font_args(15) textAlignment:0];
    }
    return _nameLb;
}

- (UILabel *)categoryLb {
    if (!_categoryLb) {
        _categoryLb = [[UILabel alloc] initWithText:@"22" textColor:k_black_color textFont:k_text_font_args(13) textAlignment:0];
    }
    return _categoryLb;
}

- (UILabel *)priceLb {
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] initWithText:@"" textColor:k_textgray_color textFont:k_text_font_args(14) textAlignment:2];
        _priceLb.numberOfLines = 2;
    }
    return _priceLb;
}

- (UILabel *)raseLb {
    if (!_raseLb) {
        _raseLb = [[UILabel alloc] initWithText:@"" textColor:k_textgray_color textFont:k_text_font_args(14) textAlignment:2];
    }
    return _raseLb;
}

- (void)setupUI {
    [self addSubview:self.augurImg];
    [self addSubview:self.nameLb];
    [self addSubview:self.categoryLb];
    [self addSubview:self.priceLb];
    [self addSubview:self.raseLb];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_augurImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(18)));
    }];
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CalculateHeight(10));
        make.left.equalTo(_augurImg.mas_right).offset(CalculateWidth(15));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(15)));
    }];
    [_categoryLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLb.mas_bottom).offset(CalculateHeight(5));
        make.left.equalTo(_nameLb);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(10)));
    }];
    [_raseLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(20));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(150), CalculateHeight(20)));
    }];
    [_priceLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_raseLb.mas_left).offset(-CalculateWidth(10));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(40)));
    }];
}

- (void)setModel:(OptionCoinModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.nameLb.text = model.coin_name;
    self.categoryLb.text = model.market;
    self.priceLb.text = [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? [NSString stringWithFormat:@"￥%@ $%@", model.oneday_highest_cny, model.oneday_highest_usd] : [NSString stringWithFormat:@"$%@ ￥%@", model.oneday_highest_usd, model.oneday_highest_cny];
    
}

@end

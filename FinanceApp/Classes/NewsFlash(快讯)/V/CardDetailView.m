//
//  CardDetailView.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "CardDetailView.h"

@interface CardDetailView()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *currencyLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *precentLb;

@property (nonatomic, strong) UILabel *ratedLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation CardDetailView

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImg;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithText:@"" textColor:k_black_title textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    }
    return _title;
}

- (UILabel *)currencyLb {
    if (!_currencyLb) {
        _currencyLb = [[UILabel alloc] initWithText:@"currency" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _currencyLb;
}

- (UILabel *)priceLb {
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _priceLb;
}

- (UILabel *)precentLb {
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _priceLb;
}

- (UILabel *)ratedLb {
    if (!_ratedLb) {
        _ratedLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _ratedLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(12)) textAlignment:2];
    }
    return _timeLb;
}
- (void)setupUI {
    [self addSubview:self.backView];
    [self.backView addSubview:self.iconImg];
    [self.backView addSubview:self.title];
    [self.backView addSubview:self.currencyLb];
    [self.backView addSubview:self.priceLb];
    
    [self.backView addSubview:self.ratedLb];
    [self.backView addSubview:self.timeLb];
}


@end

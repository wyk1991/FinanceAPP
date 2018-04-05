//
//  CardDetailView.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "CardDetailView.h"
#import "FlashModel.h"

@interface CardDetailView()
@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *currencyLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *precentLb;

@property (nonatomic, strong) UILabel *ratedLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation CardDetailView

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        _backView.image = [UIImage imageNamed:@"ic_flash_rectangle"];
    }
    return _backView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImg;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithText:@"" textColor:k_black_title textFont:k_textB_font_args(CalculateHeight(15)) textAlignment:0];
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
        _priceLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(9)) textAlignment:0];
    }
    return _priceLb;
}

- (UILabel *)ratedLb {
    if (!_ratedLb) {
        _ratedLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(9)) textAlignment:1];
    }
    return _ratedLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithText:@"" textColor:k_currenty_text textFont:k_text_font_args(CalculateHeight(9)) textAlignment:2];
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

- (void)setCardModel:(CardModel *)cardModel {
    if (_cardModel != cardModel) {
        _cardModel = cardModel;
    }
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:cardModel.icon_url] placeholderImage:nil];
    _title.text = cardModel.coin_name;
    _priceLb.text = [NSString stringWithFormat:@"%@ / %@  %@",cardModel.sale_amount, cardModel.total_amount, cardModel.percentage];
    _ratedLb.text = cardModel.rating;
    _timeLb.text = [NSString stringWithFormat:@"%@", cardModel.end_time];
    
    if (!cardModel) {
        [self.backView removeFromSuperview];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.size.height.mas_equalTo(CalculateHeight(80));
    }];
    [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(31));
        make.top.offset(CalculateHeight(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(39), CalculateHeight(39)));
    }];
    [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(10));
        make.top.offset(CalculateHeight(13));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(15)));
    }];
    [_currencyLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(CalculateHeight(6));
        make.left.equalTo(_title);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(12)));
    }];
    [_priceLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.top.equalTo(_currencyLb.mas_bottom).offset(CalculateHeight(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(250), CalculateHeight(9)));
    }];
    [_ratedLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_iconImg);
        make.bottom.offset(-CalculateHeight(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(50), CalculateHeight(9)));
    }];
    [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_ratedLb);
        make.right.offset(-CalculateWidth(25));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(9)));
    }];
}

@end

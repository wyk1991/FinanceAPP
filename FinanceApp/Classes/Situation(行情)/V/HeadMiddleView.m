//
//  HeadMiddleView.m
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "HeadMiddleView.h"
#import "ChartsDetailModel.h"

@interface HeadMiddleView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *iconNameLb;
@property (nonatomic, strong) UILabel *middleLb;
@property (nonatomic, strong) UILabel *bottomLb;
@property (nonatomic, strong) UIButton *roseBtn;
@property (nonatomic, strong) UIImageView *noticeImg;
@property (nonatomic, strong) UILabel *maxPrice;
@property (nonatomic, strong) UILabel *minPrice;
@property (nonatomic, strong) UILabel *totalPrice;

@end

@implementation HeadMiddleView
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = k_white_color;
    }
    return _backView;
}

- (UILabel *)iconNameLb {
    if (!_iconNameLb) {
        _iconNameLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(18)) textAlignment:0];
    }
    return _iconNameLb;
}

- (UILabel *)middleLb {
    if (!_middleLb) {
        _middleLb = [[UILabel alloc] initWithText:@"" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    }
    return _middleLb;
}

- (UILabel *)bottomLb {
    if (!_bottomLb) {
        _bottomLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(22)) textAlignment:0];
    }
    return _bottomLb;
}

- (UIButton *)roseBtn {
    if (!_roseBtn) {
        _roseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _roseBtn.layer.cornerRadius = 10.0f;
        _roseBtn.layer.masksToBounds = YES;
        _roseBtn.userInteractionEnabled = NO;
        [_roseBtn setTitle:@"3.32%" forState:UIControlStateNormal];
        [_roseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_roseBtn setBackgroundColor:[UIColor redColor]];
        _roseBtn.titleLabel.font = k_text_font_args(CalculateHeight(12));
    }
    return _roseBtn;
}

- (UIImageView *)noticeImg {
    if (!_noticeImg) {
        _noticeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_hangqing_lingdang"]];
        _noticeImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panNoticeImg:)];
        [_noticeImg addGestureRecognizer:pan];
    }
    return _noticeImg;
}

- (UILabel *)maxPrice {
    if (!_maxPrice) {
        _maxPrice = [[UILabel alloc] initWithText:@"最高  ￥1939399" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _maxPrice;
}

-  (UILabel *)minPrice {
    if (!_minPrice) {
        _minPrice = [[UILabel alloc] initWithText:@"最低  ￥193391" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _minPrice;
}

- (UILabel *)totalPrice {
    if (!_totalPrice) {
        _totalPrice = [[UILabel alloc] initWithText:@"成交  0.92万" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _totalPrice;
}

- (void)setupUI {
    [self addSubview:self.backView];
    [self.backView addSubview:self.iconNameLb];
    [self.backView addSubview:self.middleLb];
    [self.backView addSubview:self.bottomLb];
    [self.backView addSubview:self.roseBtn];
    [self.backView addSubview:self.noticeImg];
    [self.backView addSubview:self.maxPrice];
    [self.backView addSubview:self.minPrice];
    [self.backView addSubview:self.totalPrice];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.size.height.mas_equalTo(CalculateHeight(104));
    }];
    [_iconNameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateWidth(17));
        make.left.offset(CalculateWidth(13));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    [_middleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconNameLb.mas_bottom).offset(CalculateHeight(5));
        make.left.equalTo(_iconNameLb);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(15)));
    }];
    [_bottomLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLb.mas_bottom).offset(CalculateHeight(5));
        make.left.equalTo(_iconNameLb);
    }];
    [_roseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomLb.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_bottomLb);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(60), CalculateHeight(20)));
    }];
    [_maxPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-k_leftMargin);
        make.top.offset(CalculateHeight(15));
    }];
    [_noticeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_maxPrice.mas_left).offset(-CalculateWidth(13));
        make.top.equalTo(_maxPrice);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
    }];
    [_minPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maxPrice);
        make.top.equalTo(_maxPrice.mas_bottom).offset(CalculateHeight(5));
    }];
    [_totalPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maxPrice);
        make.top.equalTo(_minPrice.mas_bottom).offset(CalculateHeight(5));
    }];
}

- (void)panNoticeImg:(UIPanGestureRecognizer *)pan {
    if (self.block) {
        self.block(self.iconNameLb.text);
    }
}

- (void)setModel:(PricesModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.iconNameLb.text = model.trading_market_name;
    self.middleLb.text = [NSString stringWithFormat:@"￥%@",model.price_cny];
    self.bottomLb.text = [NSString stringWithFormat:@"＄%@", model.price_usd];
    [self.roseBtn setTitle:[model.change containsString:@"-"] ? [NSString stringWithFormat:@"-%@%%", model.change] :[NSString stringWithFormat:@"+%@%%", model.change] forState:UIControlStateNormal];
    self.maxPrice.text =  [NSString stringWithFormat:@"最高  ￥%@", model.oneday_highest_cny];
    self.minPrice.text = [NSString stringWithFormat:@"最低  ￥%@", model.oneday_lowest_cny];
    self.totalPrice.text = [NSString stringWithFormat:@"成交  %@", model.oneday_amount];
}


@end

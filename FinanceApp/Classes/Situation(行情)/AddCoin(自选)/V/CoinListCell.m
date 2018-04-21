//
//  CoinListCell.m
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "CoinListCell.h"
#import "CoinListModel.h"

@interface CoinListCell()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UIImageView *checkImg;
@end

@implementation CoinListCell

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
    }
    return _nameLb;
}

- (UIImageView *)checkImg {
    if (!_checkImg) {
        _checkImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning_price"]];
    }
    return _checkImg;
}

- (void)setupUI {
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.checkImg];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(CalculateWidth(15));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(20), CalculateHeight(20)));
    }];
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(10));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(15)));
    }];
    [_checkImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(15));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(20), CalculateHeight(20)));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(CoinListModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:nil];
    self.nameLb.text = model.name;
    self.checkImg.image = model.isSelect? [UIImage imageNamed:@"verified_step1_complete_icon"] : [UIImage imageNamed:@"warning_price"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.model.isSelect = selected ? @"1" : @"0";
//    if (self.selected) {
//        self.checkImg.image = [UIImage imageNamed:@"verified_step1_complete_icon"];
//    } else {
//        self.checkImg.image = [UIImage imageNamed:@"warning_price"];
//    }
}

@end

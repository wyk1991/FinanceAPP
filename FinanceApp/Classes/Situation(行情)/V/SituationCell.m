//
//  SituationCell.m
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationCell.h"
#import "CoinAllInfoModel.h"
#import "ChartsDetailModel.h"
#import "OptionCoinModel.h"

@interface SituationCell()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat labelWidth;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *numLb;

@property (nonatomic, strong) UIImageView *noticeImg;
@end

@implementation SituationCell

- (UIImageView *)augurImg {
    if (!_augurImg) {
        _augurImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_hangqing_lingdang"]];
        _augurImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(warnImgClick:)];
        [_augurImg addGestureRecognizer:ges];
    }
    return _augurImg;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:@"111" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _nameLb;
}

- (UILabel *)categoryLb {
    if (!_categoryLb) {
        _categoryLb = [[UILabel alloc] initWithText:@"22" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _categoryLb;
}

- (UILabel *)numLb {
    if (!_numLb) {
        _numLb = [[UILabel alloc] initWithText:@"1" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _numLb;
}

- (UIScrollView *)rightScrollView {
    if (!_rightScrollView) {
        _rightScrollView = [[UIScrollView alloc] init];
        _rightScrollView.backgroundColor = k_back_color;
        _rightScrollView.showsVerticalScrollIndicator = false;
        _rightScrollView.showsHorizontalScrollIndicator = false;
        
        _rightScrollView.delegate = self;
        
    }
    return _rightScrollView;
}

- (void)setupUI {
    [self.contentView addSubview:self.augurImg];
    [self.contentView addSubview:self.categoryLb];
    [self.contentView addSubview:self.numLb];
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLb];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.leftType) {
        case 0: {
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
        }
            break;
        case 1: {
            [_numLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(CalculateWidth(23));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(20), CalculateHeight(20)));
            }];
            [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_numLb.mas_right).offset(CalculateWidth(10));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(20), CalculateHeight(20)));
            }];
            [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(10));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(15)));
            }];
        }
            break;
        case 2: {
            [_augurImg mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(k_leftMargin);
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(16), CalculateHeight(19)));
            }];
            [_categoryLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_augurImg.mas_right).offset(CalculateWidth(15));
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(CalculateWidth(90), CalculateHeight(10)));
            }];
        }
            
        default:
            break;
    }
}

- (void)setModel:(CoinDetailListModel *)model withType:(CoinShowType)type{
    if (_model != model) {
        _model = model;
        _leftType = type;
    }
   
    [self.augurImg setHidden:YES];
    [self.categoryLb setHidden:YES];
    self.numLb.text = model.index;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:nil options:SDWebImageLowPriority];
    self.nameLb.text = model.name;
        
}

- (void)setPriceModel:(PricesModel *)priceModel withType:(CoinShowType)type{
    if (_priceModel != priceModel) {
        _priceModel = priceModel;
        _leftType = type;
    }
    [self.numLb setHidden:YES];
    [self.iconImg setHidden:YES];
    [self.nameLb setHidden:YES];
    [self.augurImg setHidden:NO];
    
    self.categoryLb.text = priceModel.trading_market_name;
}

- (void)setOptinModel:(OptionCoinModel *)optionModel withTypt:(CoinShowType)type {
    if (_optionModel != optionModel) {
        _optionModel = optionModel;
        _leftType = type;
    }
    [self.numLb setHidden:YES];
    [self.iconImg setHidden:YES];
    [self.nameLb setHidden:NO];
    [self.augurImg setHidden:NO];
    [self.categoryLb setHidden:NO];
    
    self.nameLb.text = optionModel.coin_name;
    self.categoryLb.text = optionModel.market;
}

- (void)warnImgClick:(UITapGestureRecognizer *)tap {
    if (self.warnBlock) {
        self.warnBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ClipBottomCell.m
//  FinanceApp
//
//  Created by SX on 2018/5/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ClipBottomCell.h"
#import "GRStarView.h"
#import "FlashModel.h"
#import "GRStarsView.h"
@interface ClipBottomCell()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UILabel *importLb;
@property (nonatomic, strong) GRStarsView *starView;

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIImageView *qrCodeImg;
@property (nonatomic, strong) UIImageView *bottomTip;

@end

@implementation ClipBottomCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_quick_share_logo_bottom"]];
    }
    return _bgView;
}

- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_time"]];
    }
    return _timeImg;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithText:[MJYUtils mjy_getSysTime] textColor:k_black_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
    }
    return _timeLb;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}

- (UILabel *)importLb {
    if (!_importLb) {
        _importLb = [[UILabel alloc] initWithText:@"重要程度" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
        _importLb.numberOfLines = 0;
    }
    return _importLb;
}

- (GRStarsView *)starView {
    if (!_starView) {
        _starView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(12, 12) margin:CalculateWidth(3) numberOfStars:5];
        _starView.allowSelect = NO;
        
    }
    return _starView;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"分享自财经APP" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:k_black_color forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = k_text_font_args(CalculateHeight(14));
        _shareBtn.userInteractionEnabled = NO;
        
    }
    return _shareBtn;
}

- (UIImageView  *)qrCodeImg {
    if (!_qrCodeImg) {
        _qrCodeImg = [[UIImageView alloc] init];
        [_qrCodeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", Base_URL, jilian_QRurl]] placeholderImage:[UIImage imageNamed:@"icon_ewm_defalut"]];
    }
    return _qrCodeImg;
}

- (UIImageView *)bottomTip {
    if (!_bottomTip) {
        _bottomTip = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quick_share_text"]];
    }
    return _bottomTip;
}

- (void)setupUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.timeImg];
    [self.bgView addSubview:self.timeLb];
    [self.bgView addSubview:self.contentLb];
    [self.bgView addSubview:self.importLb];
    [self.bgView addSubview:self.starView];
    [self.bgView addSubview:self.shareBtn];
    [self.bgView addSubview:self.qrCodeImg];
    [self.bgView addSubview:self.bottomTip];
    
}

- (void)layoutSubviews {
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    [_timeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateHeight(15));
        make.top.offset(CalculateHeight(80));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
    }];
    [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeImg.mas_right).offset(CalculateWidth(5));
        make.centerY.equalTo(_timeImg);
    }];
    [_contentLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.top.equalTo(_timeImg.mas_bottom).offset(CalculateHeight(15));
        make.right.offset(-CalculateWidth(15));
    }];
    [_importLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentLb.mas_bottom).offset(CalculateHeight(30));
        make.left.offset(CalculateWidth(15));
    }];
    [_starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLb.mas_bottom).offset(CalculateHeight(32));
        make.left.equalTo(_importLb.mas_right).offset(CalculateWidth(5));
    }];
    [_shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-CalculateHeight(30));
        make.left.offset(CalculateWidth(15));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(20)));
    }];
    [_bottomTip mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shareBtn);
        make.right.offset(-CalculateWidth(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(15)));
    }];
    [_qrCodeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomTip);
        make.bottom.equalTo(_bottomTip.mas_top).offset(CalculateHeight(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(120)));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(FlashModel *)model {
    if (model != _model) {
        _model = model;
    }
    self.contentLb.text = model.desc;
    self.starView.score = [model.hottness floatValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

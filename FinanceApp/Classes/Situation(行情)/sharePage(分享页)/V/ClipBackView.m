//
//  ClipBackView.m
//  FinanceApp
//
//  Created by SX on 2018/5/16.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ClipBackView.h"
@interface ClipBackView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UIImageView *timeImg;
@property (nonatomic, strong) UIImageView *clipImgView;
@end


@implementation ClipBackView
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(31, 45, 29);
    }
    return _backView;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithText:[MJYUtils mjy_getSysTime] textColor:k_white_color textFont:k_text_font_args(CalculateHeight(16)) textAlignment:0];
    }
    return _timeLb;
}

- (UIImageView *)timeImg {
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_share_market_date"]];
    }
    return _timeImg;
}

- (UIImageView *)clipImgView {
    
    if (!_clipImgView) {
        _clipImgView = [[UIImageView alloc] init];
    }
    return _clipImgView;
}

- (void)setupUI {
    [self addSubview:self.backView];
    [self.backView addSubview:self.timeLb];
    [self.backView addSubview:self.timeImg];
    [self.backView addSubview:self.clipImgView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(15));
        make.centerX.offset(0);
    }];
    [_timeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timeLb.mas_left).offset(-CalculateWidth(3));
        make.centerY.equalTo(_timeLb);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
    }];
    [_clipImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLb.mas_bottom).offset(CalculateHeight(15));
        make.left.offset(CalculateWidth(10));
        make.right.offset(-CalculateWidth(10));
        make.bottom.offset(CalculateHeight(20));
    }];
    
}

- (void)setClipImg:(UIImage *)clipImg {
    if (_clipImg != clipImg) {
        _clipImg = clipImg;
    }
    self.clipImgView.image = clipImg;
}


@end

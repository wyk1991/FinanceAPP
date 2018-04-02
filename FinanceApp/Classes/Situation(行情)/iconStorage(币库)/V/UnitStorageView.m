//
//  UnitStorageView.m
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UnitStorageView.h"

@interface UnitStorageView()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *count;
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation UnitStorageView

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:@"coin_info"];
        
    }
    return _iconImg;
}

- (UILabel *)count {
    if (!_count) {
        _count = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(16)) textAlignment:0];
    }
    return _count;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithText:@"" textColor:k_text_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
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
        make.left.offset(k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(18)));
    }];
    [_count mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(5));
        make.top.offset(CalculateHeight(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_count);
        make.top.equalTo(_count.mas_bottom).offset(CalculateHeight(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
}



@end

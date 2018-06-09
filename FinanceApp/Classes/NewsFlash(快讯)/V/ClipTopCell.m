//
//  ClipTopCell.m
//  FinanceApp
//
//  Created by SX on 2018/5/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ClipTopCell.h"

@interface ClipTopCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIImageView *titleImg;
@end

@implementation ClipTopCell

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_quick_share_logo_top"]];
    }
    return _bgView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_logo_jilian"]];
    }
    return _iconImg;
}

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_quick_share_news"]];
    }
    return _titleImg;
}

- (void)setupUI {
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.titleImg];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(220)));
    }];
    [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(CalculateHeight(30));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(234), CalculateHeight(56)));
    }];
    [_titleImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImg.mas_bottom).offset(CalculateHeight(20));
        make.centerX.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(204), CalculateHeight(53)));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


@end

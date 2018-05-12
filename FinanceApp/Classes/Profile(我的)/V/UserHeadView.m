//
//  UserHeadView.m
//  FinaceApp
//
//  Created by SX on 2018/3/5.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "UserHeadView.h"

@interface UserHeadView()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *arrowImg;

@property (nonatomic, strong) UIView *separView;

@end

@implementation UserHeadView

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = k_white_color;
        _backView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderView)];
        [_backView addGestureRecognizer:tap];
        
    }
    return _backView;
}

- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        ViewBorderRadius(_headImg, CalculateWidth(27), 0, k_white_color);
        [_headImg sd_setImageWithURL:[NSURL URLWithString:kApplicationDelegate.userHelper.userInfo.user.avatar_url] placeholderImage:[UIImage imageNamed:@"icon_defaut_avatar"]];
        _headImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:kApplicationDelegate.userHelper.userInfo.user.nickname.length ? kApplicationDelegate.userHelper.userInfo.user.nickname: @"点击登录" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(16)) textAlignment:0];
        
    }
    return _nameLb;
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right2"]];
        _arrowImg.contentMode = UIViewContentModeScaleToFill;
    }
    return _arrowImg;
}

- (UIView *)separView {
    if (!_separView) {
        _separView = [[UIView alloc] init];
        _separView.backgroundColor = k_back_color;
    }
    return _separView;
}



- (void)setupUI {
    [self addSubview:self.backView];
    [self.backView addSubview:self.headImg];
    [self.backView addSubview:self.nameLb];
    [self.backView addSubview:self.arrowImg];
    [self addSubview:self.separView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(80)));
    }];
    [_headImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView);
        make.left.offset(CalculateWidth(15));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(54), CalculateHeight(54)));
    }];
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImg.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_headImg);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(300), CalculateHeight(20)));
    }];
    [_arrowImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(15));
        make.centerY.equalTo(_headImg);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(8), CalculateHeight(18)));
    }];
    [_separView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.size.height.mas_equalTo(CalculateHeight(10));
    }];
}

- (void)clickHeaderView {
    if (_delegate && [_delegate respondsToSelector:@selector(userHeader:didClickWithUserInfo:)]) {
        [_delegate userHeader:self didClickWithUserInfo:nil];
    }
}

- (void)resetNoInfo {
    self.nameLb.text = @"点击登录";
    [self.headImg setImage:[UIImage imageNamed:@"icon_defaut_avatar"]];
}



@end

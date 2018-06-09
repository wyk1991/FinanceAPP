//
//  MyColumnHeadView.m
//  FinanceApp
//
//  Created by SX on 2018/5/7.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "MyColumnHeadView.h"

@interface MyColumnHeadView()
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *userLb;
@property (nonatomic, strong) UIButton *fansNumbtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *artNumbtn;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *lookNumbtn;
@end

@implementation MyColumnHeadView

- (UIImageView *)userImg {
    if (!_userImg) {
        _userImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_defaut_avatar"]];
        ViewBorderRadius(_userImg, CalculateWidth(30), CalculateWidth(60), [UIColor clearColor]);
        _userImg.contentMode  = UIViewContentModeScaleAspectFit;
        if ([kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo]) {
            [_userImg sd_setImageWithURL:[NSURL URLWithString:kApplicationDelegate.userHelper.userInfo.user.avatar_url] placeholderImage:[UIImage imageNamed:@"icon_defaut_avatar"]];
        }
    }
    return _userImg;
}

- (UILabel *)userLb {
    if (!_userLb) {
        _userLb = [[UILabel alloc] initWithText:@"用户名" textColor:k_username_color textFont:k_text_font_args(14) textAlignment:0];
        if ([kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo]) {
            _userLb.text = kApplicationDelegate.userHelper.userInfo.user.nickname;
        }
    }
    return _userLb;
}

- (UIButton *)fansNumbtn {
    if (!_fansNumbtn) {
        _fansNumbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansNumbtn.userInteractionEnabled = NO;
        [_fansNumbtn setTitleColor:k_threeLb_color forState:UIControlStateNormal];
        [_fansNumbtn setTitle:@"0 粉丝" forState:UIControlStateNormal];
        [_fansNumbtn setBackgroundColor:[UIColor clearColor]];
    }
    return _fansNumbtn;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_threeLb_color;
    }
    return _line;
}

- (UIButton *)artNumbtn {
    if (!_artNumbtn) {
        _artNumbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _artNumbtn.userInteractionEnabled = NO;
        [_artNumbtn setTitleColor:k_threeLb_color forState:UIControlStateNormal];
        [_artNumbtn setTitle:@"0 文章" forState:UIControlStateNormal];
        [_artNumbtn setBackgroundColor:[UIColor clearColor]];
    }
    return _artNumbtn;
}

- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = k_threeLb_color;
    }
    return _line2;
}

- (UIButton *)lookNumbtn {
    if (!_lookNumbtn) {
        _lookNumbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookNumbtn.userInteractionEnabled = NO;
        [_lookNumbtn setTitleColor:k_threeLb_color forState:UIControlStateNormal];
        [_lookNumbtn setTitle:@"0 浏览" forState:UIControlStateNormal];
        [_lookNumbtn setBackgroundColor:[UIColor clearColor]];
    }
    return _lookNumbtn;
}

- (void)setupUI {
    self.backgroundColor = k_mycolumn_bg;
    [self addSubview:self.userImg];
    [self addSubview:self.userLb];
//    [self addSubview:self.fansNumbtn];
//    [self addSubview:self.line];
//    [self addSubview:self.artNumbtn];
//    [self addSubview:self.line2];
//    [self addSubview:self.lookNumbtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_userImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(14));
        make.top.offset(CalculateHeight(14+64));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(60), CalculateHeight(60)));
    }];
    [_userLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userImg.mas_right).offset(CalculateWidth(15));
        make.centerY.equalTo(_userImg);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(20)));
    }];
//    [_fansNumbtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_userImg.mas_bottom).offset(CalculateHeight(15));
//        make.left.offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, CalculateHeight(20)));
//    }];
//    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_fansNumbtn.mas_right).offset(0);
//        make.centerY.equalTo(_fansNumbtn);
//        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), CalculateHeight(15)));
//    }];
//    [_artNumbtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_fansNumbtn);
//        make.left.equalTo(_fansNumbtn.mas_right).offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, CalculateHeight(20)));
//    }];
//    [_line2 mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_artNumbtn.mas_right).offset(0);
//        make.centerY.equalTo(_fansNumbtn);
//        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), CalculateHeight(15)));
//    }];
//    [_lookNumbtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_fansNumbtn);
//        make.right.offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, CalculateHeight(20)));
//    }];
}


@end

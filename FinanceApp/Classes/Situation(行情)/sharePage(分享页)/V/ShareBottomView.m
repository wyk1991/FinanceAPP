//
//  ShareBottomView.m
//  FinanceApp
//
//  Created by SX on 2018/5/16.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ShareBottomView.h"

@interface ShareBottomView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *qqBtn;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *wechatFriendBtn;

@property (nonatomic, strong) UIButton *downloadBtn;

@end

@implementation ShareBottomView

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"quick_share_back"] forState:UIControlStateNormal];
        _backBtn.tag = 0;
        [_backBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backBtn;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = k_white_color;
    }
    return _backView;
}

- (UIButton *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"quick_share_qq"] forState:UIControlStateNormal];
        _qqBtn.tag = 1;
        [_qqBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

- (UIButton *)wechatBtn {
    if (!_wechatBtn) {
        _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatBtn setImage:[UIImage imageNamed:@"quick_share_wechat"] forState:UIControlStateNormal];
        _wechatBtn.tag = 2;
        [_wechatBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatBtn;
}

- (UIButton *)wechatFriendBtn {
    if (!_wechatFriendBtn) {
        _wechatFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wechatBtn.tag= 3;
        [_wechatFriendBtn setImage:[UIImage imageNamed:@"quick_share_friend"] forState:UIControlStateNormal];
        [_wechatFriendBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatFriendBtn;
}

- (UIButton *)downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadBtn.tag = 4;
        [_downloadBtn setImage:[UIImage imageNamed:@"quick_share_download"] forState:UIControlStateNormal];
        [_downloadBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(50)));
    }];
    [_backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(20));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(25)));
    }];
    [_downloadBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(30));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(30), CalculateHeight(30)));
    }];
    [_wechatFriendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_downloadBtn.mas_left).offset(-CalculateWidth(40));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(30), CalculateHeight(30)));
    }];
    [_wechatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wechatFriendBtn.mas_left).offset(-CalculateWidth(40));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(30), CalculateHeight(26)));
    }];
    [_qqBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wechatBtn.mas_left).offset(-CalculateWidth(40));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(26), CalculateHeight(26)));
    }];
}

- (void)setupUI {
    [self addSubview:self.backView];
    [self.backView addSubview:self.backBtn];
    [self.backView addSubview:self.qqBtn];
    [self.backView addSubview:self.wechatBtn];
    [self.backView addSubview:self.wechatFriendBtn];
    [self.backView addSubview:self.downloadBtn];
}

- (void)bottomBtnClick:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(clickTheBottomView:withTag:)]) {
        [_delegate clickTheBottomView:self withTag:sender.tag];
    }
}


@end

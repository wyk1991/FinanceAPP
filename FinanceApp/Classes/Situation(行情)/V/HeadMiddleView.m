//
//  HeadMiddleView.m
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "HeadMiddleView.h"

@interface HeadMiddleView()

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

- (UILabel *)iconNameLb {
    if (!_iconNameLb) {
        _iconNameLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(16)) textAlignment:0];
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
        _bottomLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(16)) textAlignment:0];
    }
    return _bottomLb;
}

- (UIButton *)roseBtn {
    if (!_roseBtn) {
        _roseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
        _noticeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_xiaoxi"]];
        _noticeImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panNoticeImg:)];
        [_noticeImg addGestureRecognizer:pan];
    }
    return _noticeImg;
}

- (UILabel *)maxPrice {
    if (!_maxPrice) {
        _maxPrice = [[UILabel alloc] initWithText:@"最高  ￥1939399" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:2];
    }
    return _maxPrice;
}

-  (UILabel *)minPrice {
    if (!_minPrice) {
        _minPrice = [[UILabel alloc] initWithText:@"最低  ￥193391" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:2];
    }
    return _minPrice;
}

- (UILabel *)totalPrice {
    if (!_totalPrice) {
        _totalPrice = [[UILabel alloc] initWithText:@"成交  0.92万" textColor:k_text_color textFont:k_text_font_args(14) textAlignment:2];
    }
    return _totalPrice;
}

- (void)panNoticeImg:(UIPanGestureRecognizer *)pan {
    if (self.block) {
        self.block(self.iconNameLb.text);
    }
}

@end

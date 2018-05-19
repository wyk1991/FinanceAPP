//
//  EarthBackView.m
//  FinanceApp
//
//  Created by SX on 2018/5/16.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "EarthBackView.h"

@interface EarthBackView()

@property (nonatomic, strong) UIImageView *tipImage;
@property (nonatomic, strong) UIImageView *qrCodeImg;
@property (nonatomic, strong) UIView *earthView;

@end

@implementation EarthBackView

- (UIView *)earthView {
    if (!_earthView) {
        _earthView = [[UIView alloc] init];
        _earthView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_share_diqiu"]];
        _earthView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _earthView;
}

- (UIImageView *)tipImage {
    if (!_tipImage) {
        _tipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_share_head"]];
    }
    return _tipImage;
}

- (UIImageView *)qrCodeImg {
    if (!_qrCodeImg) {
        _qrCodeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_ewm"]];
//        _QRCodeImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _qrCodeImg;
}

- (void)setupUI {
    [self addSubview:self.earthView];
    
    [self.earthView addSubview:self.qrCodeImg];
    [self.earthView addSubview:self.tipImage];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_earthView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(30));
        make.right.offset(-CalculateWidth(30));
        make.top.offset(CalculateHeight(30));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CalculateWidth(30)*2, kScreenWidth - CalculateWidth(30)*2));
    }];
    [_tipImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-CalculateWidth(40));
        make.top.offset(CalculateHeight(40));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(91)));
    }];
    [_qrCodeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tipImage.mas_right).offset(CalculateWidth(5));
        make.bottom.equalTo(_tipImage);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(30), CalculateHeight(30)));
    }];
}


@end

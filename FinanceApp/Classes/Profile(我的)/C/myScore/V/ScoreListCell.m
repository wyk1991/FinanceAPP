//
//  ScoreListCell.m
//  FinanceApp
//
//  Created by SX on 2018/5/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ScoreListCell.h"

@interface ScoreListCell()

@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *scoreLb;

@end

@implementation ScoreListCell

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:@"BTC" textColor:RGB(51, 51, 51) textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    }
    return _nameLb;
}

- (UILabel *)scoreLb {
    if (!_scoreLb) {
        _scoreLb = [[UILabel alloc] initWithText:@"1233.12" textColor:RGB(51, 51, 51) textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    }
    return _scoreLb;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(27));
        make.centerY.offset(0);
    }];
    [_scoreLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CalculateWidth(27));
        make.centerY.offset(0);
    }];
}

- (void)setupUI {
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.scoreLb];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

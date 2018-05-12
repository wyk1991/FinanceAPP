//
//  FeedBackListCell.m
//  FinanceApp
//
//  Created by SX on 2018/5/10.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "FeedBackListCell.h"
#import "FeedBackListModel.h"

@interface FeedBackListCell()
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *content;
@end

@implementation FeedBackListCell

- (UILabel *)dateLb {
    if (!_dateLb) {
        _dateLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(10) textAlignment:0];
    }
    return _dateLb;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_line_color;
    }
    return _line;
}

- (UILabel *)typeLb {
    if (!_typeLb) {
        _typeLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:0];
    }
    return _typeLb;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(12) textAlignment:0];
    }
    return _content;
}

- (void)setupUI {
    [self.contentView addSubview:self.dateLb];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:self.typeLb];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_dateLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.top.offset(CalculateHeight(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(120), CalculateHeight(15)));
    }];
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_dateLb.mas_bottom).offset(CalculateHeight(5));
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_typeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.top.equalTo(_line.mas_bottom).offset(CalculateHeight(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(60), CalculateHeight(20)));
    }];
    [_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_typeLb.mas_right).offset(CalculateWidth(5));
        make.centerY.equalTo(_typeLb);
        make.right.offset(-CalculateWidth(10));
    }];
}

- (void)setModel:(FeedBackListModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.dateLb.text = model.create_time;
    self.typeLb.text = model.type;
    self.content.text = model.content;
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

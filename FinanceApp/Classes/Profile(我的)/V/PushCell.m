//
//  PushCell.m
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "PushCell.h"
#import "SettingModel.h"

@interface PushCell()

@property (nonatomic, strong) UIImageView *questionImg;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UISwitch *pushSwitch;

@end

@implementation PushCell

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(16) textAlignment:0];
    }
    return _titleLb;
}

- (UISwitch *)pushSwitch {
    if (!_pushSwitch) {
        _pushSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        _pushSwitch.on = NO;
        // 添加事件监听
        [_pushSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _pushSwitch;
}

- (UIImageView *)questionImg {
    if (!_questionImg) {
        _questionImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _questionImg.contentMode = UIViewContentModeScaleAspectFill;
        [_questionImg setHidden:YES];
    }
    return _questionImg;
}

- (void)setupUI {
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.questionImg];
    [self.contentView addSubview:self.pushSwitch];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(150), CalculateHeight(16)));
    }];
    [_questionImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLb);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
    }];
    [_pushSwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(60), CalculateHeight(30)));
    }];
}

- (void)setModel:(SettingModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLb.text = model.title;
    [self.questionImg setHidden:[model.title isEqualToString:@"接受新消息通知"] ? YES : NO];
    [self.pushSwitch setOn:[model.content isEqualToString:@"1"] ? YES : NO];
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

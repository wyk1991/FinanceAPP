//
//  NormalUserCell.m
//  FinaceApp
//
//  Created by SX on 2018/3/5.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "NormalUserCell.h"
#import "SettingModel.h"

@interface NormalUserCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UISwitch *switchBtn;

@property (nonatomic, strong) UIImageView *checkImg;
@end

@implementation NormalUserCell

#pragma mark - lazy method
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        
    }
    return _icon;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    }
    return _nameLb;
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right2"]];
    }
    return _arrowImg;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(15) textAlignment:2];
    }
    return _contentLb;
}

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (void)setupUI {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.arrowImg];
    [self.contentView addSubview:self.contentLb];
    [self.contentView addSubview:self.switchBtn];
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(_model.icon ? CalculateWidth(15) : 0);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(_model.icon ? CGSizeMake(CalculateWidth(20), CalculateHeight(20)) : CGSizeZero);
    }];
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).offset(_model.icon ? CalculateWidth(5) : CalculateWidth(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(250), CalculateHeight(40)));
    }];
    [_arrowImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(8), CalculateHeight(18)));
    }];
    [_switchBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_arrowImg);
        make.centerY.equalTo(self.contentView);
    }];
    [_contentLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(_arrowImg.mas_left).offset(CalculateWidth(-5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(20)));
    }];

}

- (void)setModel:(SettingModel *)model {
    if (_model != model) {
        _model = model;
    }
    if ([model.isArrow isEqualToString:@"1"] && [model.isSwitch isEqualToString:@"0"]) {
        [self.switchBtn setHidden:YES];
        if (model.icon) {
            self.icon.image = [UIImage imageNamed:model.icon];
        } else {
            [self.icon setHidden:YES];
        }
        
    } else if([model.isArrow isEqualToString:@"0"] && [model.isSwitch isEqualToString:@"0"]){
        [self.switchBtn setHidden:YES];
        [self.icon setHidden:YES];
        [self.arrowImg setHidden:YES];
//        [self.checkImg setHidden:[model.isSelect isEqualToString:@"1"] ? NO : YES];
        self.accessoryType = [model.isSelect isEqualToString:@"1"] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else {
        [self.switchBtn setHidden:NO];
        [self.switchBtn setOn:[model.isSelect isEqualToString:@"1"] ? YES :NO];
        [self.icon setHidden:YES];
        [self.arrowImg setHidden:YES];
    }
    self.nameLb.text = model.title;
    
    self.contentLb.text = model.content;

    [self setNeedsDisplay];
}

- (void)switchBtnClick:(UISwitch *)sw {
    if ([self.model.title isEqualToString:@"声音"]) {
        [MJYUtils saveToUserDefaultWithKey:user_noticeVoiceType withValue:sw.isOn ? @"1" : @"0"];
    } else if([self.model.title isEqualToString:@"震动"]){
        [MJYUtils saveToUserDefaultWithKey:user_noticeShackType withValue:sw.isOn ? @"1" : @"0"];
    } else if([self.model.title isEqualToString:@"预警按钮"]) {
        [MJYUtils saveToUserDefaultWithKey:user_earlyWaring withValue:sw.isOn ? @"1" : @"0"];
    }
    
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

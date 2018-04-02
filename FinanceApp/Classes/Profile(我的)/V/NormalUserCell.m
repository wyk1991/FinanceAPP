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

- (void)setupUI {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.arrowImg];
    [self.contentView addSubview:self.contentLb];
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(20), CalculateHeight(20)));
    }];
    [_nameLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).offset([_model.hiddenIcon isEqualToString:@"0"] ? CalculateWidth(5) : CalculateWidth(-25));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(250), CalculateHeight(40)));
    }];
    [_arrowImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(8), CalculateHeight(18)));
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
    if ([model.hiddenIcon isEqualToString:@"0"]) {
        
        self.icon.image = [UIImage imageNamed:model.icon];
    } else{
        
        [self.icon setHidden:YES];
    }
    self.nameLb.text = model.title;
    
    self.contentLb.text = model.content;

    [self setNeedsDisplay];
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

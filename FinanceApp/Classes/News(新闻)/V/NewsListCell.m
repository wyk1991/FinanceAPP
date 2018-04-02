//
//  NewsListCell.m
//  FinaceApp
//
//  Created by SX on 2018/3/7.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "NewsListCell.h"
#import "RollModel.h"

@interface NewsListCell()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UIImageView *image;

@end

@implementation NewsListCell
#pragma mark - lazy method
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(16)) textAlignment:0];
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithText:@"2018-01-01 00:00" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(13)) textAlignment:0];
    }
    return _timeLb;
}

- (UIImageView *)image {
    if (!_image) {
        _image = [[UIImageView alloc] init];
        _image.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image;
}

- (void)setupUI {
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(111), CalculateHeight(73)));
    }];
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(k_leftMargin);
        make.top.offset(k_leftMargin);
        make.right.equalTo(_image.mas_left).offset(-k_leftMargin);
    }];
    [_timeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLb);
        make.bottom.offset(-CalculateHeight(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(20)));
    }];
}

- (void)setModel:(RollModel *)model {
    _model = model;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.urlToImage] placeholderImage:nil];
    self.timeLb.text = model.publishedAt;
    self.titleLb.text = model.title;
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

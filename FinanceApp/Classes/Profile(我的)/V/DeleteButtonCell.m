//
//  DeleteButtonCell.m
//  FinaceApp
//
//  Created by SX on 2018/3/5.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "DeleteButtonCell.h"

@interface DeleteButtonCell()

@property (nonatomic, strong) UILabel *back_lb;
@end

@implementation DeleteButtonCell

- (void)setupUI {
    [self.contentView addSubview:self.back_lb];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_back_lb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
}

- (UILabel *)back_lb{
    if (!_back_lb) {
        _back_lb = [[UILabel alloc] initWithText:@"退出" textColor:k_white_color textFont:k_text_font_args(CalculateHeight(17)) textAlignment:1];
        _back_lb.backgroundColor = k_red_color;
    }
    return _back_lb;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += CalculateHeight(30);
    [super setFrame:frame];
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

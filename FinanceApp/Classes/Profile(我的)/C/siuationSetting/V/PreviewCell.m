//
//  PreviewCell.m
//  FinanceApp
//
//  Created by SX on 2018/4/16.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "PreviewCell.h"

#define kButtonWidth (kScreenWidth-CalculateWidth(30))/3
#define kButtonHeight CalculateHeight(30)

#define k_USD_arr @[@"Bitfinex", @"$188000.00  ￥15000.00", @"0.89%"]
#define k_CNY_arr @[@"Bitfinex", @"￥28930.00  $5000.00", @"0.89%"]

@interface PreviewCell()
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation PreviewCell

- (void)setupUI {
    UILabel *lb = [[UILabel alloc] initWithText:@"预览" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(15)) textAlignment:0];
    lb.frame = CGRectMake(CalculateWidth(15), CalculateHeight(15), CalculateWidth(40), CalculateHeight(15));
    [self.contentView addSubview:lb];
    
    NSArray *tmp = @[@"名称", @"最新价", @"涨幅"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CalculateWidth(15) + i*kButtonWidth, CGRectGetMaxY(lb.frame) + CalculateHeight(20), kButtonWidth, kButtonHeight);
        [btn setTitle:tmp[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:k_titlePrice_color];
        [btn setTitleColor:k_pricetitle_color forState:UIControlStateNormal];
        btn.layer.borderColor = k_greenMain_color.CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.textAlignment = 1;
        btn.titleLabel.font = k_text_font_args(CalculateHeight(15));
        
        [self.contentView addSubview:btn];
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(CalculateWidth(15), CGRectGetMaxY(lb.frame) + CalculateHeight(50), kButtonWidth * 3, 80)];
    bottomView.backgroundColor = k_white_color;
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = k_back_color.CGColor;
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*kButtonWidth, 0, kButtonWidth, kButtonHeight*2.5);
        [btn setTitle:@"12222222" forState:UIControlStateNormal];
        btn.tag = i;
        [btn setBackgroundColor:k_white_color];
        [btn setTitleColor:i==0 ? k_priceName_color : (i== 1 ? k_newPrice_color : k_raise_color)  forState:UIControlStateNormal];
        btn.layer.borderColor = k_greenMain_color.CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.textAlignment = 1;
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.font = k_text_font_args(CalculateHeight(15));
        
        [bottomView addSubview:btn];
    }
    self.bottomView = bottomView;
    [self.contentView addSubview:self.bottomView];
    
}

- (void)setType:(NSIndexPath *)type {
    if (_type != type) {
        _type = type;
    }
    NSArray *contentArr = self.type.row == 0? k_CNY_arr : k_USD_arr;
    for (UIButton *btn in self.bottomView.subviews) {
        [btn setTitle:contentArr[btn.tag] forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
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

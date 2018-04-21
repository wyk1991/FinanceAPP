//
//  FeedBackCell.m
//  FinanceApp
//
//  Created by SX on 2018/4/17.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "FeedBackCell.h"
#import "FeedBackModel.h"

@interface FeedBackCell()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@end

@implementation FeedBackCell

- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = @[].mutableCopy;
    }
    return _buttons;
}

- (UITextView *)tv {
    if (!_tv) {
        _tv = [[UITextView alloc] initWithFrame:CGRectZero];
        _tv.textAlignment = 0;
        _tv.showsVerticalScrollIndicator = false;
        _tv.showsHorizontalScrollIndicator = false;
        _tv.scrollEnabled = NO;
        _tv.placeholderFont = k_text_font_args(CalculateHeight(15));
        _tv.textColor = k_black_color;
    }
    
    return _tv;
}

- (UITextField *)tf {
    if (!_tf) {
        _tf = [[UITextField alloc] initWithFrame:CGRectZero];
        _tf.textAlignment = 0;
        _tf.textColor = k_black_color;
        _tf.borderStyle = UITextBorderStyleNone;
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.font = k_text_font_args(CalculateHeight(15));
    }
    return _tf;
}

- (UIView *)backView {
    if(!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = k_white_color;
        
        NSArray *titles = @[
                            @"功能建议",
                            @"体验建议",
                            @"内容建议",
                            @"其他"];
        CGFloat width = (kScreenWidth - CalculateWidth(75)) / 4.f;
        CGFloat margin = CalculateWidth(15);
        CGFloat height = CalculateHeight(30);
        for (NSInteger index = 0; index < 4; index++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom
                                ];
            button.layer.cornerRadius = 10.f;
            button.titleLabel.font = k_text_font_args(CalculateHeight(13));
            button.layer.borderColor = k_themeblue_color.CGColor;
            button.layer.borderWidth = CalculateWidth(1);
            [button setTitle:titles[index] forState:normal];
            [button setTitleColor:k_black_color forState:normal];
            [button setTitleColor:k_themeblue_color forState:UIControlStateSelected];
            [button addTarget:self action:@selector(problemFeedbackTypeButtonAction:) forControlEvents:64];
            button.tag = index+1;
            button.frame = CGRectMake(index*(width+margin) + margin, CalculateHeight(10), width, height);
            [_backView addSubview:button];
            [self.buttons addObject:button];
        }
    }
    return _backView;
}

- (void)setupUI {
    [self.contentView addSubview:self.tf];
    [self.contentView addSubview:self.tv];
    [self.contentView addSubview:self.backView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_tv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(CalculateWidth(20));
        make.right.offset(-CalculateWidth(20));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CalculateWidth(20)*2, CalculateHeight(230)));
    }];
    [_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(CalculateWidth(20));
        make.right.offset(-CalculateWidth(20));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CalculateWidth(20)*2, CalculateHeight(40)));
    }];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.size.height.mas_equalTo(CalculateHeight(50));
    }];
}

- (void)setModel:(FeedBackModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.tv.placeholder = model.placeholder;
    self.tf.placeholder = model.placeholder;
    [self.tv setHidden:[model.isTv isEqualToString:@"1"] ? NO : YES];
    [self.tf setHidden:[model.isTf isEqualToString:@"1"] ? NO : YES];
    [self.backView setHidden:[model.isMoreSel isEqualToString:@"1"] ? NO :YES];
}

- (void)problemFeedbackTypeButtonAction:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.selected) return;
    [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selected) {
            obj.selected = NO;
        }
    }];
    sender.selected = YES;
    _problemType = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    NSLog(@"%@", sender.titleLabel.text);
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

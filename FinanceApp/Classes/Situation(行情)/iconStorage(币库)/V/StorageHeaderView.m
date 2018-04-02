//
//  StorageHeaderView.m
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "StorageHeaderView.h"
#import "UnitStorageView.h"

@interface StorageHeaderView()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UITextField *seacrhText;

@end

@implementation StorageHeaderView

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coin_info"]];
    }
    return _iconImg;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb  = [[UILabel alloc] initWithText:@"货币信息" textColor:k_black_color textFont:k_textB_font_args(CalculateHeight(16)) textAlignment:0];
    }
    return _titleLb;
}

- (UITextField *)seacrhText {
    if (!_seacrhText) {
        _seacrhText = [[UITextField alloc] init];
        [_seacrhText setAllowsEditingTextAttributes:NO];
        [_seacrhText setLeftViewWithImageName:@"minIcon_search"];
//        [_seacrhText setPlaceholder:@""];
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"名称、简称" attributes:@{NSFontAttributeName : k_text_font_args(CalculateHeight(17)), NSForegroundColorAttributeName : k_text_color}];
        [_seacrhText setAttributedPlaceholder:string];
//        [_seacrhText setPlaceholderColor:k_text_color];
        
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSeachText)];
        [_seacrhText addGestureRecognizer:pan];
        
        
    }
    return _seacrhText;
}

- (void)setupUI {
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(150))];
    self.topView.backgroundColor = [UIColor clearColor];
    
    CGFloat viewW = (kScreenWidth/2);
    CGFloat viewH = CalculateHeight(150)/2;
    for (int i=0; i<4; i++) {
        int row = i/2;
        int col = i%2;
        UnitStorageView *view = [[UnitStorageView alloc] initWithFrame:CGRectMake(col *viewW, row * viewH, viewW, CalculateHeight(150)/2)];
        view.backgroundColor = k_white_color;
        
        [self.topView addSubview:view];
    }
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kScreenWidth, CalculateHeight(20))];
    self.lineView.backgroundColor = k_back_color;
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame), kScreenWidth, CalculateHeight(75))];
    self.bottomView.backgroundColor = k_white_color;
    [self addSubview:self.topView];
    [self addSubview:self.lineView];
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.iconImg];
    [self.bottomView addSubview:self.titleLb];
    [self.bottomView addSubview:self.seacrhText];
}

- (void)clickSeachText {
    if (_delegate && [_delegate respondsToSelector:@selector(clickSearchTextWithIconType:)]) {
        [_delegate clickSearchTextWithIconType:@"1"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
    }];
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(5));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(40), CalculateHeight(15)));
    }];
    [_seacrhText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CalculateWidth(-k_leftMargin));
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(150), CalculateHeight(40)));
    }];
}

@end

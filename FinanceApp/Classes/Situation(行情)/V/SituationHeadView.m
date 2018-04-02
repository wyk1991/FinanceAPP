//
//  SituationHeadView.m
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationHeadView.h"

@interface SituationHeadView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UILabel *title;

@end

@implementation SituationHeadView

- (instancetype)initWithTopArr:(NSMutableArray *)arr{
    if (self = [super init]) {
        
        self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((kScreenWidth/2 - CalculateWidth(50)), 0, kScreenWidth, CalculateHeight(44))];
        self.topScrollView.showsVerticalScrollIndicator = false;
        self.topScrollView.showsHorizontalScrollIndicator = false;
        self.topScrollView.backgroundColor =  RGB(216, 221, 226);
        
        CGFloat labelW = arr.count == 2 ? (kScreenWidth/2 - CalculateWidth(50)) / arr.count : kScreenWidth * 2.5 / arr.count;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = [[UILabel alloc] initWithText:arr[idx] textColor:RGB(142, 142, 142) textFont:k_text_font_args(14) textAlignment:0];
            [self.topScrollView addSubview:label];
        }];
        self.topScrollView.contentSize = CGSizeMake(labelW * arr.count, 0);
        self.topScrollView.delegate = self;
        
    }
    return self;
}

- (UIView *)backView1 {
    if (!_backView1) {
        _backView1 = [UIView new];
        _backView1.backgroundColor = RGB(227, 232, 238);
    }
    return _backView1;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithText:@"名称" textColor:RGB(142, 142, 142) textFont:k_text_font_args(CalculateHeight(14)) textAlignment:0];
    }
    return _title;
}


- (void)setupUI {
    [self addSubview:self.topScrollView];
    [self addSubview:self.backView1];
    [self.backView1 addSubview:self.title];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.offset(0);
        make.size.mas_equalTo(CGSizeMake(1/2 * kScreenWidth - CalculateWidth(50), CalculateHeight(44)));
    }];
    [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(k_leftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(30), CalculateHeight(15)));
    }];
    
}

@end

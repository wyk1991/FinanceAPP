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
@property (nonatomic, strong) UIView *searchBackView;

@end

@implementation StorageHeaderView

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_currency_information"]];
    }
    return _iconImg;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb  = [[UILabel alloc] initWithText:@"货币信息" textColor:k_black_title textFont:k_textB_font_args(CalculateHeight(17)) textAlignment:0];
    }
    return _titleLb;
}

- (UIView *)searchBackView {
    if (!_searchBackView) {
        _searchBackView = [[UIView alloc] init];
        _searchBackView.layer.borderWidth = 1.0f;
        _searchBackView.layer.borderColor = k_back_color.CGColor;
        _searchBackView.layer.cornerRadius = 5.0f;
        _searchBackView.layer.masksToBounds = YES;
        
        UITextField *searchTf = [[UITextField alloc] init];
        [searchTf setEnabled:YES];
        searchTf.backgroundColor = k_white_color;
        searchTf.textColor = k_siuation_searchText;
        searchTf.placeholder = @"名称、简称";
        searchTf.font = k_text_font_args(CalculateHeight(12));
        // 创建左侧视图
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_search"]];
        //        img.frame = CGRectMake(0, 0, CalculateWidth(30), CalculateHeight(30));
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CalculateWidth(15), CalculateHeight(23))];
        
        img.center = lv.center;
        [lv addSubview:img];
        searchTf.leftViewMode = UITextFieldViewModeAlways;
        searchTf.leftView = lv;
        
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSeachText)];
        [searchTf addGestureRecognizer:pan];
        
        [_searchBackView addSubview:searchTf];
        [searchTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(CalculateWidth(5));
            make.right.offset(0);
            make.size.height.equalTo(@(CalculateHeight(23)));
        }];
    }
    return _searchBackView;
}

- (void)setupUI {
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CalculateHeight(144))];
    self.topView.backgroundColor = [UIColor clearColor];
    CGFloat viewW = (kScreenWidth/2);
    CGFloat viewH = CalculateHeight(150)/2;
    for (int i=0; i<4; i++) {
        int row = i/2;
        int col = i%2;
        UnitStorageView *view = [[UnitStorageView alloc] init];
        view.frame = CGRectMake(col *viewW, row * viewH, viewW, CalculateHeight(150)/2);
        view.tag = i;
        
        view.backgroundColor = k_white_color;
        
        [self.topView addSubview:view];
    }
    
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kScreenWidth, CalculateHeight(15/2))];
    self.lineView.backgroundColor = k_back_color;
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame), kScreenWidth, CalculateHeight(52))];
    self.bottomView.backgroundColor = k_white_color;
    [self addSubview:self.topView];
    [self addSubview:self.lineView];
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.iconImg];
    [self.bottomView addSubview:self.titleLb];
    [self.bottomView addSubview:self.searchBackView];
    
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
        make.centerY.offset(0).offset(CalculateHeight(15/4));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(25), CalculateHeight(25)));
    }];
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(CalculateWidth(10));
        make.centerY.offset(0).offset(CalculateHeight(15/4));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(17)));
    }];
    [_searchBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLb.mas_right).offset(CalculateWidth(15));
        make.centerY.offset(0).offset(CalculateHeight(15/4));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
}

- (void)setDataArr:(NSArray *)dataArr {
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[UnitStorageView class]]) {
        UnitStorageView *uView= (UnitStorageView *)view;
        uView.model = dataArr[view.tag];
        }
    }
}


@end

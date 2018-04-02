//
//  HomeMiddleView.m
//  FinanceApp
//
//  Created by SX on 2018/3/24.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "HomeMiddleView.h"
#import "NewsModel.h"

@interface HomeMiddleView()<TXScrollLabelViewDelegate>

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *cateTypeLb;
//@property (nonatomic, strong) UILabel *contentLb;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) TXScrollLabelView *scrollLabelView;

@property (nonatomic, assign) int index;
@end

@implementation HomeMiddleView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        
        
    }
    return self;
}

- (void)setScrollLabelWithArr:(NSArray *)arr{
    self.scrollLabelView = [TXScrollLabelView scrollWithTextArray:arr type:TXScrollLabelViewTypeFlipRepeat velocity:2 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    
    self.scrollLabelView.scrollLabelViewDelegate = self;
    self.scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.scrollLabelView.scrollSpace = 5;
    self.scrollLabelView.font = k_text_font_args(CalculateHeight(14));
    self.scrollLabelView.textAlignment = 1;
    self.scrollLabelView.backgroundColor = k_white_color;
    self.scrollLabelView.tx_centerX = kScreenWidth / 3;
    
    [self addSubview:self.scrollLabelView];
    [_scrollLabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line.mas_right).offset(CalculateWidth(10));
        make.right.offset(CalculateWidth(-10));
        make.centerY.offset(0);
        make.size.height.mas_equalTo(CalculateHeight(50));
    }];
    
    
    [self.scrollLabelView beginScrolling];
    
}

- (UILabel *)title {
    if (!_title) {
        
        _title = [[UILabel alloc] initWithText:@"极链快讯" textColor:k_black_color textFont:[UIFont systemFontOfSize:CalculateHeight(15) weight:1.3] textAlignment:0];
    }
    return _title;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_line_color;
    }
    return _line;
}

- (UIButton *)cateTypeLb {
    if (!_cateTypeLb) {
        _cateTypeLb = [UIButton buttonWithType:UIButtonTypeCustom];
        _cateTypeLb.userInteractionEnabled = NO;
        [_cateTypeLb setTitle:@"11:30" forState:UIControlStateNormal];
        [_cateTypeLb setTitleColor:k_white_color forState:UIControlStateNormal];
        _cateTypeLb.titleLabel.font = k_text_font_args(CalculateHeight(15));
        [_cateTypeLb setBackgroundImage:[UIImage imageNamed:@"ic_redrectangle"] forState:UIControlStateNormal];
        _cateTypeLb.titleLabel.textAlignment = 1;
        
        _cateTypeLb.layer.cornerRadius = 3.0f;
        _cateTypeLb.layer.masksToBounds = YES;
    }
    return _cateTypeLb;
}

//- (UILabel *)contentLb {
//    if (!_contentLb) {
//        _contentLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(15) textAlignment:0];
//        _contentLb.numberOfLines = 2;
//    }
//    return _contentLb;
//}

- (void)setupUI {
    self.backgroundColor = k_white_color;
    [self addSubview:self.title];
    [self addSubview:self.cateTypeLb];
    [self addSubview:self.line];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(23));
        make.top.offset(CalculateHeight(15));
    }];
    [_cateTypeLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(15));
        make.top.equalTo(_title.mas_bottom).offset(CalculateHeight(3));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(32)));
    }];
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cateTypeLb.mas_right).offset(CalculateWidth(10));
        make.top.offset(CalculateHeight(18));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(1), CalculateHeight(45)));
    }];
    
}



- (void)setModelArr:(NSMutableArray *)modelArr {
    if (_modelArr != modelArr) {
        _modelArr = modelArr;
    }
    [self setScrollLabelWithArr:modelArr];
    
    NSArray *time = @[@"12:30", @"10:23", @"10:22"];
    self.index = 2;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeTheTime:) userInfo:@{@"userinfo": time} repeats:YES];
    self.timer = timer;
    
    /** Step2: 创建 ScrollLabelView */
    TXScrollLabelView *scrollLabelView = nil;
    scrollLabelView = [TXScrollLabelView scrollWithTextArray:modelArr type:2 velocity:2 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    
    
    /** Step3: 设置代理进行回调 */
    scrollLabelView.scrollLabelViewDelegate = self;
    
    /** Step4: 布局(Required) */
    scrollLabelView.frame = CGRectMake(self.frame.size.width/2 - CalculateWidth(50) , CalculateHeight(20), CalculateWidth(200), CalculateHeight(45));
    
    [self addSubview:scrollLabelView];
    
    //偏好(Optional), Preference,if you want.
//    scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
    scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
    scrollLabelView.scrollSpace = 10;
    scrollLabelView.font = [UIFont systemFontOfSize:15];
    scrollLabelView.textAlignment = NSTextAlignmentCenter;
    scrollLabelView.backgroundColor = [UIColor clearColor];
    scrollLabelView.scrollTitleColor = k_black_color;
//    scrollLabelView.layer.cornerRadius = 5;
    
    /** Step5: 开始滚动(Start scrolling!) */
    [scrollLabelView beginScrolling];
    
    
    [self setNeedsLayout];
    
}

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index {
    NSLog(@"%@--%ld",text, index);
}

- (void)changeTheTime:(NSTimer *)timer {
    if (self.index == -1) {
        self.index = 2;
    }
    NSArray *arr = [timer.userInfo valueForKey:@"userinfo"];
    [self.cateTypeLb setTitle:arr[self.index] forState:UIControlStateNormal];
    self.index--;
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end

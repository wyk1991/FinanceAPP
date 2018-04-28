//
//  TimeButton.m
//  LD
//
//  Created by 徐洋 on 2016/11/24.
//  Copyright © 2016年 Losdeoro24K. All rights reserved.
//

#import "TimeButton.h"

@interface TimeButton ()

@property (nonatomic, assign) NSInteger t;
@property (nonatomic, assign) NSInteger totalTime;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TimeButton
#pragma mark init
- (instancetype)initTimeButtonWithTime:(NSInteger)time{
    if (self = [super init]) {
        _t = _totalTime = time;
        [self setSubViews];
    }
    return self;
}
#pragma mark delegate
- (void)buttonAction:(UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(timeClickButtonAction)]) {
        [self.delegate timeClickButtonAction];
    }
}
#pragma mark action
- (void)start
{
    NSLog(@"start");
    if (_t == 0 || _t == _totalTime) {
        _t = _totalTime;
        [_timer setFireDate:[NSDate date]];
    }
}
- (void)reset
{
    _button.enabled = YES;
    [_timer setFireDate:[NSDate distantFuture]];
    [_button setTitleColor:k_main_color forState:normal];
    [_button setTitle:@"重新获取" forState:normal];
}
- (void)getMessage
{
    if (_t == 0) {
        [self reset];
        return;
    }
    _t --;
    [_button setTitle:[self getTimeStr] forState:normal];
    _button.enabled = NO;
    [_button setTitleColor:k_main_color forState:normal];


}
- (NSString *)getTimeStr
{
    return [NSString stringWithFormat:@"(%lds)后重新获取", (long)_t];
}
#pragma mark UI
- (void)setSubViews
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"获取验证码" forState:normal];
    [_button setTitleColor:k_textgray_color forState:normal];
//    _button.layer.cornerRadius = CalculateHeight(3);
//    _button.layer.masksToBounds = YES;
    _button.backgroundColor = k_white_color;
    _button.titleLabel.font = [UIFont systemFontOfSize:CalculateHeight(12)];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getMessage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer setFireDate:[NSDate distantFuture]];
}
#pragma mark frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    WS(weakSelf);
    [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end

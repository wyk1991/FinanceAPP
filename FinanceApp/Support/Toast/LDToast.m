//
//  LDToast.m
//  LD
//
//  Created by 徐洋 on 2016/11/10.
//  Copyright © 2016年 Losdeoro24K. All rights reserved.
//

#import "LDToast.h"

@implementation LDToast

static LDToast *_toast = nil;
+ (instancetype)shareLDToast
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _toast = [[self alloc] init];
    });
    return _toast;
}

+ (void)dismiss
{
    _toast = [self shareLDToast];
    [_toast removeFromSuperview];
}

+ (void)dis
{
    _toast = [self shareLDToast];
    [UIView animateWithDuration:1.f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _toast.frame = CGRectMake(_toast.frame.origin.x, _toast.frame.origin.y - 30, _toast.frame.size.width, _toast.frame.size.height);
        _toast.alpha = .3f;
    } completion:^(BOOL finished) {
        [_toast removeFromSuperview];
    }];
}

+ (void)showToastWith:(NSString *)msg
{
    _toast = [self shareLDToast];
    for (UIView *v in kWindow.subviews) {
        if (v == _toast) {
            return;
        }
    }
    _toast.alpha = 1.f;
    [_toast.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _toast.backgroundColor = [k_black_color colorWithAlphaComponent:.8f];
    _toast.layer.masksToBounds = YES;
    _toast.layer.cornerRadius = 5.f;
    [kWindow addSubview:_toast];
    UILabel *label = [UILabel new];
    label.text = msg;
    label.font = k_text_font_args(16);
    label.numberOfLines = 0;
    label.textColor = k_white_color;
    label.textAlignment = 1;
    [_toast addSubview:label];
    [label sizeToFit];
    CGFloat width = (label.frame.size.width > 130 ? 130 : label.frame.size.width) > 80 ? 130 : 80;
    label.frame = CGRectMake(0, 0, width, 0);
    [label sizeToFit];
    CGFloat height = label.frame.size.height > 20 ? label.frame.size.height : 20;
    _toast.frame = CGRectMake(0, 0, width + 20, height + 10);
    _toast.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.f, [UIScreen mainScreen].bounds.size.height * .8f);
    label.frame = CGRectMake(10, 5, width, height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dis];
    });
}

@end

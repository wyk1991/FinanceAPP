//
//  SettingFontViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/5/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SettingFontViewController.h"

#define kSettingWidth (kScreenWidth - CalculateWidth(100) - CalculateWidth(20)*4)/3

@interface SettingFontViewController ()
@property (nonatomic, strong) UIView  *backView;
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UIButton *smallBtn;
@property (nonatomic, strong) UIButton *middleBtn;
@property (nonatomic, strong) UIButton *maxBtn;
@end

@implementation SettingFontViewController
- (UIView *)backView {
    if (!_backView) {
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor grayColor];
        _backView.bounds = CGRectMake(0, 0, kScreenWidth - CalculateWidth(50)*2, CalculateHeight(120));
        _backView.layer.cornerRadius = 10.0f;
        _backView.layer.masksToBounds = YES;
        
    }
    return _backView;
}

- (void)setupUI {
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    
    // 弹框
    
    [self addSubview:self.backView];
    
    self.tipLb = [[UILabel alloc] initWithText:@"字体大小" textColor:k_white_color textFont:k_text_font_args(17) textAlignment:1];
    self.tipLb.frame = CGRectMake((_backView.frame.size.width - CalculateWidth(80)) / 2, CalculateHeight(10), CalculateWidth(80), CalculateHeight(20));
    
    [self.backView addSubview:self.tipLb];
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CalculateWidth(20)*(i+1) + i*kSettingWidth, CGRectGetMaxY(self.tipLb.frame) + CalculateHeight(40), kSettingWidth, CalculateHeight(30));
        btn.layer.cornerRadius = 3.f;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = k_text_font_args(CalculateHeight(12));
        btn.tag = i;
        [btn setTitle:SettingFontArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:k_white_color forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(k_loginmain_color)] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)([UIColor clearColor])] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        
        if ([[kNSUserDefaults valueForKey:user_webFontSize] isEqualToString:[NSString stringWithFormat:@"%d", i]]) {
            [btn setBackgroundColor:k_loginmain_color];
        }
        
        [btn addTarget:self action:@selector(clickSettingFont:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backView addSubview:btn];
        
    }
    
    // 添加点击手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGes];
}

// 点击其他区域关闭弹窗
- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [sender locationInView:nil];
        if (![_backView pointInside:[_backView convertPoint:location fromView:_backView.window] withEvent:nil]) {
            [_backView.window removeGestureRecognizer:sender];
            [self removeFromSuperview];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)show {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self createShowAnimation];
}

#pragma mark - 弹出动画效果
- (void)createShowAnimation {
    self.backView.layer.position = self.center;
    self.backView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)clickSettingFont:(UIButton *)sender {
    for (UIButton *btn in self.backView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (sender == btn) {
                [sender setBackgroundColor:k_loginmain_color];
            } else {
                [btn setBackgroundColor:[UIColor clearColor]];
            }
        }
        
    }
    if (self.fontBlock) {
        self.fontBlock(sender.tag);
    }
}

//-(void)dismiss {
//
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self removeFromSuperview];
//
//}
//
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismiss];
//}



//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

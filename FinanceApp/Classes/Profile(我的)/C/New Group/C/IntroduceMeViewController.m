//
//  IntroduceMeViewController.m
//  FinanceApp
//
//  Created by SX on 2018/5/8.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "IntroduceMeViewController.h"

#define maxTVNum 30

@interface IntroduceMeViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextView *tv;
@property (nonatomic, strong) UILabel *tipLb;

@end

@implementation IntroduceMeViewController

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = k_white_color;
    }
    return _backView;
}

- (UITextView *)tv {
    if (!_tv) {
        _tv = [[UITextView alloc] init];
        _tv.backgroundColor = [UIColor clearColor];
        _tv.returnKeyType = UIReturnKeyDone;
        _tv.font = k_text_font_args(CalculateHeight(12));
        _tv.delegate = self;
        _tv.placeholder = @"快向读者介绍一下自己吧";
        _tv.placeholderTextColor = k_textgray_color;
        _tv.placeholderFont = k_text_font_args(CalculateHeight(14));
    }
    return _tv;
}

- (UILabel *)tipLb {
    if (!_tipLb) {
        _tipLb = [[UILabel alloc] initWithText:@"0/30" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(12)) textAlignment:2];
    }
    return _tipLb;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人简介";
    [self setRightItem];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.tv];
    [self.backView addSubview:self.tipLb];
    [self addMasnory];
}

- (void)addMasnory {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(15/2));
        make.left.right.offset(0);
        make.height.mas_equalTo(CalculateHeight(250));
    }];
    [_tv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CalculateWidth(30));
        make.right.offset(-CalculateWidth(30));
        make.top.offset(CalculateHeight(20));
        make.height.mas_equalTo(CalculateHeight(100));
    }];
    [_tipLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-CalculateHeight(10));
        make.right.offset(-CalculateWidth(10));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(20)));
    }];
}

- (void)setRightItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
}

- (void)save {
    
}

#pragma mark - textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]|| textView.text.length > 30) {
        [self.tv resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    UITextRange *selectedRange = [textView markedTextRange];
    // 获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        return;
    }
    NSUInteger count = textView.text.length;
    if (count > 0 && count <= maxTVNum) {
        self.tipLb.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)count, (long)maxTVNum];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

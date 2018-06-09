//
//  PassWordView.m
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "PassWordView.h"

@interface PassWordView()<TimeClickDelegate>

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) TimeButton *timeBtn;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UITextField *againPasswordTf;
@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation PassWordView

- (UITextField *)codeTf {
    if (!_codeTf) {
        _codeTf = [[UITextField alloc] init];
        _codeTf.placeholder = @"验证码";
        _codeTf.font = k_text_font_args(CalculateHeight(14));
        _codeTf.textAlignment = NSTextAlignmentLeft;
        _codeTf.keyboardType = UIKeyboardTypePhonePad;
        _codeTf.textColor = k_textgray_color;
        
    }
    return _codeTf;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = k_textgray_color;
    }
    return _line;
}

- (TimeButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [[TimeButton alloc] initTimeButtonWithTime:60];
        _timeBtn.delegate = self;
        
    }
    return _timeBtn;
}

- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = k_textgray_color;
    }
    return _line1;
}

- (UITextField *)passwordTf {
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.placeholder = @"请输入最少8位的密码";
        _passwordTf.font = k_text_font_args(CalculateHeight(14));
        _passwordTf.keyboardType = UIKeyboardTypeDefault;
        _passwordTf.secureTextEntry = YES;
        _passwordTf.textColor = k_black_color;
    }
    return _passwordTf;
}

- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = k_textgray_color;
    }
    return _line2;
}

- (UITextField *)againPasswordTf {
    if (!_againPasswordTf) {
        _againPasswordTf = [[UITextField alloc] init];
        _againPasswordTf.placeholder = @"确认密码";
        _againPasswordTf.font = k_text_font_args(CalculateHeight(14));
        _againPasswordTf.keyboardType = UIKeyboardTypeDefault;
        _againPasswordTf.secureTextEntry = YES;
        _againPasswordTf.textColor = k_black_color;
    }
    return _againPasswordTf;
}

- (UIView *)line3 {
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = k_textgray_color;
    }
    return _line3;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:k_greenMain_color];
        [_sureBtn setTitleColor:k_white_color forState:UIControlStateNormal];
        _sureBtn.titleLabel.textAlignment = 1;
        _sureBtn.titleLabel.font = k_text_font_args(CalculateHeight(16));
        
        _sureBtn.layer.cornerRadius = 10.0f;
        _sureBtn.layer.masksToBounds = true;
        
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)setupUI {
    [self addSubview:self.line1];
    [self addSubview:self.codeTf];
    [self addSubview:self.line];
    [self addSubview:self.passwordTf];
    [self addSubview:self.timeBtn];
    [self addSubview:self.againPasswordTf];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    [self addSubview:self.sureBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_codeTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(10));
        make.left.offset(CalculateWidth(30));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeTf.mas_right).offset(CalculateWidth(5));
        make.centerY.equalTo(_codeTf);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), CalculateHeight(25)));
    }];
    [_timeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_line);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    [_line1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTf.mas_bottom).offset(CalculateHeight(3));
        make.left.offset(CalculateWidth(30));
        make.right.offset(-CalculateWidth(30));
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_passwordTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom).offset(CalculateHeight(40));
        make.left.equalTo(_codeTf);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTf.mas_bottom).offset(CalculateHeight(3));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_againPasswordTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).offset(CalculateHeight(40));
        make.left.equalTo(_codeTf);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_againPasswordTf.mas_bottom).offset(CalculateHeight(3));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3).offset(CalculateHeight(30));
        make.left.equalTo(_codeTf);
        make.right.equalTo(_line1);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CalculateWidth(30)*2, CalculateHeight(44)));
    }];
}

- (void)sureBtnClick:(UIButton *)btn {
    
    [self endEditing:YES];
    if (!self.codeTf.text  && !self.passwordTf.text && !self.againPasswordTf.text) {
        [LDToast showToastWith:@"请输入选项内容"];
        return;
    }
    if (![self.passwordTf.text isEqualToString:self.againPasswordTf.text]) {
        [LDToast showToastWith:@"两者输入的密码不一致"];
        return;
    }
    NSDictionary *dic = @{@"phone": [kNSUserDefaults valueForKey:user_telephoneBinding],
                          @"code": self.codeTf.text,
                          @"password": self.againPasswordTf.text
                          };
    if (_delegate && [_delegate respondsToSelector:@selector(clickSureBtn:withInfo:)]) {
        [_delegate clickSureBtn:self withInfo:dic];
    }
}

- (void)timeClickButtonAction {
    [self.timeBtn start];
    [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    if (_delegate && [_delegate respondsToSelector:@selector(clickTimeBtn:)]) {
        [_delegate clickTimeBtn:self];
    }
}

- (void)setSecureType:(SecureType)secureType {
    if (secureType == 0) {
        
    }
}




@end

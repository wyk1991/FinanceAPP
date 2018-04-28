//
//  RegisterView.m
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView()<TimeClickDelegate>

@property (nonatomic, strong) UILabel *areaCode;
@property (nonatomic, strong) UIView *carveOneView;
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) UIView *carveTwoView;
@property (nonatomic, strong) TimeButton *timeBtn;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UITextField *againPasswordTf;
@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UILabel *agreenLb;

@end

@implementation RegisterView

- (instancetype)initWithTypeView:(LoginViewType)type {
    self = [super init];
    if (self) {
        self.type = type;
        
        [self setupUI];
    }
    return self;
}

- (UILabel *)areaCode {
    if (!_areaCode) {
        _areaCode = [[UILabel alloc] initWithText:@"+86" textColor:k_textgray_color textFont:k_text_font_args(CalculateWidth(14)) textAlignment:0];
    }
    return _areaCode;
}

- (UIView *)carveOneView {
    if (!_carveOneView) {
        _carveOneView = [[UIView alloc] init];
        _carveOneView.backgroundColor = k_textgray_color;
        
    }
    return _carveOneView;
}

- (UITextField *)phoneTf {
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.placeholder = @"请输入手机号";
        _phoneTf.font = k_text_font_args(CalculateHeight(14));
        _phoneTf.keyboardType = UIKeyboardTypePhonePad;
        _phoneTf.textColor = k_black_color;
    }
    return _phoneTf;
}

- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = k_textgray_color;
    }
    return _line1;
}

- (UITextField *)codeTf {
    if (!_codeTf) {
        _codeTf = [[UITextField alloc] init];
        _codeTf.placeholder = @"请输入手机验证码";
        _codeTf.font = k_text_font_args(CalculateHeight(14));
        _codeTf.textAlignment = NSTextAlignmentLeft;
        _codeTf.keyboardType = UIKeyboardTypePhonePad;
        _codeTf.delegate = self;
        _codeTf.textColor = k_textgray_color;
        
    }
    return _codeTf;
}

- (UIView *)carveTwoView {
    if (!_carveTwoView) {
        _carveTwoView = [[UIView alloc] init];
        _carveTwoView.backgroundColor = k_textgray_color;
    }
    return _carveTwoView;
}

- (TimeButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [[TimeButton alloc] initTimeButtonWithTime:60];
        _timeBtn.delegate = self;
        
    }
    return _timeBtn;
}

- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = k_textgray_color;
    }
    return _line2;
}

- (UITextField *)passwordTf {
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.placeholder = @"请输入新密码";
        _passwordTf.font = k_text_font_args(CalculateHeight(14));
        _passwordTf.keyboardType = UIKeyboardTypeDefault;
        _passwordTf.secureTextEntry = YES;
        _passwordTf.textColor = k_black_color;
    }
    return _passwordTf;
}

- (UIView *)line3 {
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = k_textgray_color;
    }
    return _line3;
}

- (UITextField *)againPasswordTf {
    if (!_againPasswordTf) {
        _againPasswordTf = [[UITextField alloc] init];
        _againPasswordTf.placeholder = @"确认密码";
        _againPasswordTf.secureTextEntry = YES;
        _againPasswordTf.font = k_text_font_args(CalculateHeight(14));
        _againPasswordTf.keyboardType = UIKeyboardTypeDefault;
        _againPasswordTf.textColor = k_black_color;
    }
    return _againPasswordTf;
}

- (UIView *)line4 {
    if (!_line4) {
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = k_textgray_color;
    }
    return _line4;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:k_textgray_color];
        [_sureBtn setTitleColor:k_black_color forState:UIControlStateNormal];
        _sureBtn.titleLabel.textAlignment = 1;
        _sureBtn.titleLabel.font = k_text_font_args(CalculateHeight(16));
        
        _sureBtn.layer.cornerRadius = 10.0f;
        _sureBtn.layer.masksToBounds = true;
        
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)clickBtn {
    if (!_clickBtn) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_clickBtn setImage:[UIImage imageNamed:@"icon_unpress"] forState:UIControlStateNormal];
        [_clickBtn setImage:[UIImage imageNamed:@"check_login"] forState:UIControlStateSelected];
        
        [_clickBtn addTarget:self action:@selector(clickBtnCheck:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clickBtn;
}

- (UILabel *)agreenLb {
    if (!_agreenLb) {
        _agreenLb = [[UILabel alloc] initWithText:@"我已阅读并接受" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(18)) textAlignment:0];
    }
    return _agreenLb;
}

- (void)setupUI {
    [self addSubview:self.areaCode];
    [self addSubview:self.carveOneView];
    [self addSubview:self.phoneTf];
    [self addSubview:self.line1];
    [self addSubview:self.codeTf];
    [self addSubview:self.carveTwoView];
    [self addSubview:self.timeBtn];
    [self addSubview:self.line2];
    
    [self addSubview:self.passwordTf];
    [self addSubview:self.line3];
    [self addSubview:self.againPasswordTf];
    [self addSubview:self.line4];
    if (self.type == RegisterType) {
        [self addSubview:self.clickBtn];
        [self addSubview:self.agreenLb];
    }
    
    [self addSubview:self.sureBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_areaCode mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(40));
        make.left.offset(CalculateWidth(30));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(40), CalculateHeight(20)));
    }];
    [_carveOneView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaCode.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), CalculateHeight(25)));
    }];
    [_phoneTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_carveOneView.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaCode);
        make.top.equalTo(_phoneTf.mas_bottom).offset(CalculateHeight(3));
        make.right.offset(-CalculateWidth(30));
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_codeTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom).offset(CalculateHeight(40));
        make.left.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_carveTwoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeTf.mas_right).offset(CalculateWidth(5));
        make.centerY.equalTo(_codeTf);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), CalculateHeight(25)));
    }];
    [_timeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_carveTwoView.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_carveTwoView);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    [_line2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTf.mas_bottom).offset(CalculateHeight(3));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    
    [_passwordTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).offset(CalculateHeight(40));
        make.left.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTf.mas_bottom).offset(CalculateHeight(3));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_againPasswordTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3.mas_bottom).offset(CalculateHeight(40));
        make.left.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_againPasswordTf.mas_bottom).offset(CalculateHeight(3));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    
    if (self.type == RegisterType) {
        [_clickBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_line4.mas_bottom).offset(CalculateHeight(20));
            make.left.equalTo(_areaCode);
            make.size.mas_equalTo(CGSizeMake(CalculateWidth(15), CalculateHeight(15)));
        }];
        [_agreenLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_clickBtn.mas_right).offset(CalculateWidth(10));
            make.top.equalTo(_clickBtn);
            make.right.equalTo(_line1);
            make.size.height.mas_equalTo(CalculateHeight(15));
        }];
    }
    
    [_sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line4.mas_bottom).offset(self.type == RegisterType ? CalculateHeight(100): CalculateHeight(50));
        make.left.equalTo(_areaCode);
        make.right.equalTo(_line1);
        make.size.height.mas_equalTo(CalculateHeight(44));
    }];
}

- (void)sureBtnClick:(UIButton *)btn {
    
    if (!self.areaCode.text) {
        [LDToast showToastWith:@"手机号码不能为空"];
        return;
    }
    
    if (!self.codeTf.text) {
        [LDToast showToastWith:@"请输入手机验证码"];
        return;
    }
    if (self.type == RegisterType && ![self.clickBtn isSelected]) {
        [LDToast showToastWith:@"请同意改条款才可以注册"];
        return;
    }
    
    // 校验两次密码是否一致
    if (![self.passwordTf.text isEqualToString:self.againPasswordTf.text]) {
        [LDToast showToastWith:@"两次输入的验证码不一致"];
        return;
    }
    
    NSDictionary *param = @{@"phone": self.phoneTf.text,
                            @"code": self.codeTf.text,
                            @"password": self.passwordTf.text
                            };
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickSureBtn:withInfo:)]) {
        [_delegate clickSureBtn:self withInfo:param];
    }
}

- (void)timeClickButtonAction {
    [self endEditing:YES];
    if (!self.phoneTf.text) {
        [LDToast showToastWith:@"请先填写手机号码"];
        return;
    }
    if (![MJYUtils mjy_checkTel:self.phoneTf.text]) {
        [LDToast showToastWith:@"请填写正确格式的手机号码"];
        return;
    }
    [self.timeBtn start];
    if (_delegate && [_delegate respondsToSelector:@selector(clickTimeBtn:withTel:)]) {
        [_delegate clickTimeBtn:self withTel:self.phoneTf.text];
    }
}

- (void)setType:(LoginViewType)type {
    if (_type != type) {
        _type = type;
    }
    [self.sureBtn setTitle:_type == ForgetType ? @"完成" : @"注册" forState:UIControlStateNormal];
}

- (void)clickBtnCheck:(UIButton *)btn {
    [btn setSelected:!btn.isSelected];
    if (self.areaCode.text && self.codeTf.text && self.passwordTf.text && self.againPasswordTf.text && !btn.isSelected) {
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

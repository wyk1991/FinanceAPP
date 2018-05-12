//
//  LoginView.m
//  FinaceApp
//
//  Created by SX on 2018/3/6.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()<UITextFieldDelegate, TimeClickDelegate>

@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *areaCode;
@property (nonatomic, strong) UIView *carveOneView;
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) UIView *carveTwoView;
@property (nonatomic, strong) TimeButton *timeBtn;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIButton *goBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UILabel *bottomLb;
@property (nonatomic, strong) UIImageView *wechatImg;
@end

@implementation LoginView

- (UILabel *)tipLb {
    if (!_tipLb) {
        _tipLb = [[UILabel alloc] initWithText:@"验证即可登录, 未注册用户将根据手机号自动创建账号" textColor:k_login_tip textFont:k_text_font_args(CalculateHeight(12)) textAlignment:0];
        _tipLb.numberOfLines = 1;
    }
    return _tipLb;
}

- (UILabel *)areaCode {
    if (!_areaCode) {
        _areaCode = [[UILabel alloc] initWithText:@"+86" textColor:k_login_tip textFont:k_text_font_args(CalculateWidth(13)) textAlignment:0];
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
        _phoneTf.font = k_text_font_args(CalculateHeight(14));
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号"];
        [placeHolder setAttributes:@{NSForegroundColorAttributeName :k_placehold_color} range:NSMakeRange(0, 4)];
        _phoneTf.attributedPlaceholder = placeHolder;
        _phoneTf.keyboardType = UIKeyboardTypePhonePad;
        _phoneTf.textColor = k_black_color;
        
        
        [_phoneTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
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
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机验证码"];
        [placeHolder setAttributes:@{NSForegroundColorAttributeName :k_placehold_color} range:NSMakeRange(0, 7)];
        _phoneTf.attributedPlaceholder = placeHolder;
        _codeTf.delegate = self;
        _codeTf.textColor = k_textgray_color;
        
        
        [_codeTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
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

- (UIButton *)goBtn {
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
        [_goBtn setTitleColor:k_pass_goBtn forState:UIControlStateNormal];
        _goBtn.titleLabel.font = k_text_font_args(CalculateHeight(15));
        _goBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_goBtn addTarget:self action:@selector(goBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBtn;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:k_textgray_color forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:k_login_unContent];
        [_loginBtn setTitleColor:k_white_color forState:UIControlStateSelected];
        
        _loginBtn.layer.cornerRadius = 5.0f;
        _loginBtn.layer.masksToBounds = YES;
        
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIView *)line3 {
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = k_textgray_color;
    }
    return _line3;
}

- (UIView *)line4 {
    if (!_line4) {
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = k_textgray_color;
    }
    return _line4;
}

- (UILabel *)bottomLb {
    if (!_bottomLb) {
        
        _bottomLb = [[UILabel alloc] initWithText:@"使用第三方账号登录" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(15)) textAlignment:1];
    }
    return _bottomLb;
}

- (UIImageView *)wechatImg {
    if (!_wechatImg) {
        _wechatImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_wechat"]];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapWeChatImg)];
        
        [_wechatImg addGestureRecognizer:pan];
        
    }
    return _wechatImg;
}


- (void)setupUI {
    [self addSubview:self.tipLb];
    [self addSubview:self.areaCode];
    [self addSubview:self.carveOneView];
    [self addSubview:self.phoneTf];
    [self addSubview:self.line1];
    [self addSubview:self.codeTf];
    [self addSubview:self.carveTwoView];
    [self addSubview:self.timeBtn];
    [self addSubview:self.line2];
    [self addSubview:self.goBtn];
    [self addSubview:self.loginBtn];
    
    [self addSubview:self.line3];
    [self addSubview:self.line4];
    [self addSubview:self.bottomLb];
    [self addSubview:self.wechatImg];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_tipLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(30));
        make.left.offset(CalculateWidth(32));
        make.right.offset(-CalculateWidth(32));
    }];
    [_areaCode mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLb.mas_bottom).offset(CalculateHeight(34));
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
        make.top.equalTo(_phoneTf.mas_bottom).offset(CalculateHeight(10));
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
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(80), CalculateHeight(15)));
    }];
    [_line2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTf.mas_bottom).offset(CalculateHeight(5));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(0.5));
    }];
    [_goBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).offset(CalculateHeight(10));
        make.left.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(30)));
    }];
    [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaCode);
        make.right.offset(-CalculateWidth(30));
        make.top.equalTo(_goBtn.mas_bottom).offset(CalculateHeight(30));
        make.size.height.mas_equalTo(CalculateHeight(44));
    }];
    
    [_line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(CalculateHeight(100));
        make.left.offset(CalculateWidth(30));
        make.size.mas_equalTo(CGSizeMake(((kScreenWidth - CalculateWidth(220))/2), CalculateHeight(0.5)));
    }];
    
    [_line4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(30));
        make.top.equalTo(_line3);
        make.size.mas_equalTo(CGSizeMake(((kScreenWidth - CalculateWidth(220))/2), CalculateHeight(0.5)));
    }];
    [_bottomLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(CalculateHeight(90));
        make.left.equalTo(_line3.mas_right).offset(CalculateWidth(5));
        make.right.equalTo(_line4.mas_left).offset(-CalculateWidth(5));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(150), CalculateHeight(20)));
    }];
    
    [_wechatImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLb.mas_bottom).offset(CalculateHeight(40));
        make.centerX.equalTo(_bottomLb);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(50), CalculateHeight(50)));
    }];
}

- (void)timeClickButtonAction {
    if (!self.phoneTf.text.length) {
        [LDToast showToastWith:@"请填写验证码"];
        return;
    }
    if (![MJYUtils mjy_checkTel:self.phoneTf.text]) {
        [LDToast showToastWith:@"请填写正确格式的手机号码"];
        return;
    }
    [self.timeBtn start];
    if (_delegate && [_delegate respondsToSelector:@selector(clickTimeBtnClickWith:)]) {
        [_delegate clickTimeBtnClickWith:self.phoneTf.text];
    }
}

- (void)goBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(clickGoLoginPageClick)]) {
        [_delegate clickGoLoginPageClick];
    }
}

- (void)loginBtnClick:(UIButton *)btn {
    if (!self.phoneTf.text.length) {
        [LDToast showToastWith:@"请填写手机号码"];
        return;
    }
    if (!self.phoneTf.text.length) {
        [LDToast showToastWith:@"请填写短信验证码"];
        return;
    }
    
    NSDictionary *dic = @{
                          @"phone": self.phoneTf.text,
                          @"code": self.codeTf.text
                          };
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickLoginBtnClickWith:withInfo:)]) {
        [_delegate clickLoginBtnClickWith:self withInfo:dic];
    }
    NSLog(@"点击了登录");
}

- (void)tapWeChatImg {
    if (_delegate && [_delegate respondsToSelector:@selector(clickChatImgClickWith:)]) {
        [_delegate clickChatImgClickWith:self];
    }
}

- (void)setType:(LoginViewType)type {
    if (_type != type) {
        _type = type;
    }
    [self.goBtn setHidden:type == 0 ? YES : NO];
    [self.loginBtn setTitle:type == 1 ? @"登录" : @"绑定" forState:UIControlStateNormal];
    [self.wechatImg setHidden:type == 1 ? NO : YES];
    [self.line3 setHidden:type == 1 ? NO : YES];
    [self.line4 setHidden:type == 1 ? NO : YES];
    [self.bottomLb setHidden:type == 1 ? NO : YES];
    
}

-(void)textFieldChange:(UITextField *)theTextField{
    if ([self.phoneTf.text isEqualToString:@""]) {
        if ([self.codeTf.text isEqualToString:@""]) {
            self.loginBtn.backgroundColor = k_login_unContent;
            [self.loginBtn setTitleColor:k_textgray_color forState:UIControlStateNormal];
            self.loginBtn.enabled = NO;
        } else {
            self.loginBtn.backgroundColor = k_login_unContent;
            [self.loginBtn setTitleColor:k_textgray_color forState:UIControlStateNormal];
            self.loginBtn.enabled = NO;
        }
    } else {
        if ([self.codeTf.text isEqualToString:@""]) {
            self.loginBtn.backgroundColor = k_login_unContent;
            [self.loginBtn setTitleColor:k_textgray_color forState:UIControlStateNormal];
            self.loginBtn.enabled = NO;
        } else {
            self.loginBtn.backgroundColor = k_main_color;
            [self.loginBtn setTitleColor:k_white_color forState:UIControlStateNormal];
            self.loginBtn.enabled = YES;
        }
    }
}


@end

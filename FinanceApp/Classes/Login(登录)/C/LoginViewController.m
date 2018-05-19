//
//  LoginViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/3/10.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"
#import "UserInfoModelHelper.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *areaCode;
@property (nonatomic, strong) UIView *carveOneView;
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIButton *goBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIView *btnLine;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UILabel *bottomLb;
@property (nonatomic, strong) UIImageView *wechatImg;

@property (nonatomic, strong) UserInfoModelHelper *helper;

@end

@implementation LoginViewController

- (UserInfoModelHelper *)helper {
    if (!_helper) {
        _helper = (UserInfoModelHelper *)[UserInfoModelHelper shareInstance];
        
    }
    return _helper;
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
        _phoneTf.delegate = self;
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
        _codeTf.placeholder = @"请输入密码";
        _codeTf.font = k_text_font_args(CalculateHeight(14));
        _codeTf.textAlignment = NSTextAlignmentLeft;
        _codeTf.keyboardType = UIKeyboardTypePhonePad;
        _codeTf.delegate = self;
        _codeTf.textColor = k_textgray_color;
        
        [_codeTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTf;
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
        [_goBtn setTitle:@"手机号快捷登录" forState:UIControlStateNormal];
        [_goBtn setTitleColor:k_greenMain_color forState:UIControlStateNormal];
        _goBtn.titleLabel.font = k_text_font_args(CalculateHeight(15));
        
        [_goBtn addTarget:self action:@selector(goBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBtn;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:k_black_color forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:k_textgray_color forState:UIControlStateHighlighted];
        _forgetBtn.titleLabel.font = k_text_font_args(CalculateHeight(17));
        
        [_forgetBtn addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

- (UIView *)btnLine {
    if (!_btnLine) {
        _btnLine = [[UIView alloc] init];
        _btnLine.backgroundColor = k_textgray_color;
    }
    return _btnLine;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:k_black_color forState:UIControlStateNormal];
        [_registerBtn setTitleColor:k_textgray_color forState:UIControlStateHighlighted];
        _registerBtn.titleLabel.font = k_text_font_args(CalculateHeight(17));
        
        [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
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


- (void)initUI {
    [super initUI];
    [self.view addSubview:self.areaCode];
    [self.view addSubview:self.carveOneView];
    [self.view addSubview:self.phoneTf];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.codeTf];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.goBtn];
    [self.view addSubview:self.loginBtn];
    
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.btnLine];
    [self.view addSubview:self.registerBtn];
    
    [self.view addSubview:self.line3];
    [self.view addSubview:self.line4];
    [self.view addSubview:self.bottomLb];
    [self.view addSubview:self.wechatImg];
    
    [self addMasnory];
}

- (void)addMasnory {
    [_areaCode mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(40));
        make.left.offset(CalculateWidth(30));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(40), CalculateHeight(20)));
    }];
    [_carveOneView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaCode.mas_right).offset(CalculateWidth(10));
        make.centerY.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(1), CalculateHeight(25)));
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
        make.height.mas_equalTo(CalculateHeight(1));
    }];
    [_codeTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom).offset(CalculateHeight(40));
        make.left.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(30)));
    }];
    [_line2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTf.mas_bottom).offset(CalculateHeight(5));
        make.left.equalTo(_line1);
        make.right.equalTo(_line1);
        make.height.mas_equalTo(CalculateHeight(1));
    }];
    [_goBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).offset(CalculateHeight(10));
        make.left.equalTo(_areaCode);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(110), CalculateHeight(30)));
    }];
    [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaCode);
        make.right.offset(-CalculateWidth(30));
        make.top.equalTo(_goBtn.mas_bottom).offset(CalculateHeight(30));
        make.size.height.mas_equalTo(CalculateHeight(44));
    }];
    
    [_btnLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(_loginBtn.mas_bottom).offset(CalculateHeight(30));
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(0.5), CalculateHeight(20)));
    }];
    
    [_forgetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btnLine.mas_left).offset(-CalculateWidth(10));
        make.top.equalTo(_btnLine);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    
    [_registerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnLine.mas_right).offset(CalculateWidth(10));
        make.top.equalTo(_btnLine);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(100), CalculateHeight(20)));
    }];
    
    
    [_line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnLine.mas_bottom).offset(CalculateHeight(130));
        make.left.offset(CalculateWidth(30));
        make.size.mas_equalTo(CGSizeMake(((kScreenWidth - CalculateWidth(220))/2), CalculateHeight(1)));
    }];
    
    [_line4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CalculateWidth(30));
        make.top.equalTo(_line3);
        make.size.mas_equalTo(CGSizeMake(((kScreenWidth - CalculateWidth(220))/2), CalculateHeight(1)));
    }];
    [_bottomLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnLine.mas_bottom).offset(CalculateHeight(120));
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_white_color;
    self.title = @"密码登录";
}

- (void)goBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forgetBtnClick:(UIButton *)btn {
    ForgetViewController *vc = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerBtnClick:(UIButton *)btn {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginBtnClick:(UIButton *)btn {
    if (!self.phoneTf.text.length || !self.codeTf.text.length) {
        [LDToast showToastWith:@"填写的内容不能为空"];
        return;
    }
    NSDictionary *dic = @{
                          @"phone": self.phoneTf.text,
                          @"password": self.codeTf.text
                          };
    [self.helper loginButtonWithUserInfo:dic callback:^(id obj, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSuccessNotification object:nil];
    }];
}

// 登录微信
- (void)tapWeChatImg {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

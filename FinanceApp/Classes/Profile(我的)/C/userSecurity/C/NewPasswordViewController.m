//
//  NewPasswordViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "NewPasswordViewController.h"

#import "PassWordView.h"
#import "VaildationCodeHelper.h"

@interface NewPasswordViewController ()<SettingPasswordDelegate>

@property (nonatomic, strong) UIScrollView *backScoller;

@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *bindTelLb;
@property (nonatomic, strong) PassWordView *psView;

@property (nonatomic, strong) UserHelper *helper;
@property (nonatomic, strong) VaildationCodeHelper *vailteHelper;
@end

@implementation NewPasswordViewController

- (UserHelper *)helper {
    if (!_helper) {
        _helper = [UserHelper shareHelper];
    }
    return _helper;
}

- (VaildationCodeHelper *)vailteHelper {
    if (!_vailteHelper) {
        _vailteHelper = [[VaildationCodeHelper alloc] init];
    }
    return _vailteHelper;
}

- (UIScrollView *)backScoller {
    if (!_backScoller) {
        _backScoller = [[UIScrollView alloc] init];
        _backScoller.scrollEnabled = YES;
        _backScoller.backgroundColor = k_white_color;
    }
    return _backScoller;
}

- (PassWordView *)psView {
    if (!_psView) {
        _psView = [[PassWordView alloc] init];
        _psView.delegate = self;
    }
    return _psView;
}

- (UILabel *)tipLb {
    if (!_tipLb) {
        _tipLb = [[UILabel alloc] initWithText:@"设置密码后可使用手机号密码登录极链财经APP" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:1];
    }
    return _tipLb;
}

- (UILabel *)bindTelLb {
    if (!_bindTelLb) {
        _bindTelLb = [[UILabel alloc] initWithText:[kNSUserDefaults valueForKey:user_telephoneBinding] textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(17)) textAlignment:1];
    }
    return _bindTelLb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (void)initUI {
    [super initUI];
    self.view.backgroundColor = k_white_color;
    [self.view addSubview:self.tipLb];
    [self.view addSubview:self.bindTelLb];
    
    [self.view addSubview:self.psView];
    [self addMasnory];
}

- (void)addMasnory {
    [_tipLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(20));
        make.centerX.offset(0);
    }];
    [_bindTelLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLb.mas_bottom).offset(CalculateHeight(10));
        make.centerX.equalTo(_tipLb);
    }];
    [_psView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bindTelLb.mas_bottom).offset(CalculateHeight(20));
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, CalculateHeight(300)));
    }];
}

#pragma mark - action method
- (void)clickTimeBtn:(PassWordView *)pwView {
    [self.vailteHelper helperGetValidationCodeCallback:^(id obj, NSError *error) {
        
    } telStr:[kNSUserDefaults valueForKey:user_telephoneBinding]];
}

- (void)clickSureBtn:(PassWordView *)pwView withInfo:(NSDictionary *)infoDic {
    [SVProgressHUD showWithStatus:@"正在提交数据"];
    [self.helper changeThePasswordWithPath:update_user_password withInfo:infoDic callBack:^(id obj, NSError *error) {
        [SVProgressHUD dismiss];
        if ([obj[@"status"] integerValue] == 100) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [LDToast showToastWith:obj[@"msg"]];
            return ;
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setBindingTel:(NSString *)bindingTel {
    self.bindTelLb.text = [NSString stringWithFormat:@"当前绑定手机号: %@",bindingTel ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

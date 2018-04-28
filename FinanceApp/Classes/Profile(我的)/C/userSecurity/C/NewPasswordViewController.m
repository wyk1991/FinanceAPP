//
//  NewPasswordViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "NewPasswordViewController.h"

#import "PassWordView.h"

@interface NewPasswordViewController ()<SettingPasswordDelegate>

@property (nonatomic, strong) UIScrollView *backScoller;

@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *bindTelLb;
@property (nonatomic, strong) PassWordView *psView;

@end

@implementation NewPasswordViewController

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
        _bindTelLb = [[UILabel alloc] initWithText:@"当前绑定手机号: 139****1229" textColor:k_textgray_color textFont:k_text_font_args(CalculateHeight(17)) textAlignment:1];
    }
    return _bindTelLb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.backScoller];
    
    [self.backScoller addSubview:self.psView];
    [self.backScoller addSubview:self.tipLb];
    [self.backScoller addSubview:self.bindTelLb];
    
    [self addMasnory];
}

- (void)addMasnory {
    [_backScoller mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(15/2));
        make.left.right.bottom.offset(0);
    }];
    [_tipLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(20));
        make.left.offset(CalculateWidth(40));
        make.right.offset(CalculateHeight(40));
    }];
    [_bindTelLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLb.mas_bottom).offset(CalculateHeight(10));
        make.centerX.equalTo(_tipLb);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(250), CalculateHeight(25)));
    }];
    [_psView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bindTelLb.mas_bottom).offset(CalculateHeight(CalculateHeight(20)));
        make.left.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight - CalculateHeight(100)));
    }];
}

#pragma mark - action method
- (void)clickTimeBtn:(PassWordView *)pwView {
    
}

- (void)clickSureBtn:(PassWordView *)pwView withInfo:(NSDictionary *)infoDic {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

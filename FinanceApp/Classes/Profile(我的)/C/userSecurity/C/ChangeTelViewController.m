//
//  ChangeTelViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ChangeTelViewController.h"
#import "PassWordView.h"
@interface ChangeTelViewController ()<SettingPasswordDelegate>
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UILabel *telLb;

@property (nonatomic, strong) PassWordView *codeView;
@end

@implementation ChangeTelViewController
- (UILabel *)tipLb {
    if (!_tipLb) {
        _tipLb = [[UILabel alloc] initWithText:@"为确保账号安全，需要验证当前手机有效性" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:1];
    }
    return _tipLb;
}

- (UILabel *)telLb {
    if (!_telLb) {
        _telLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(16)) textAlignment:1];
    }
    return _telLb;
}

- (PassWordView *)codeView {
    if (!_codeView) {
        _codeView = [[PassWordView alloc] init];
        _codeView.delegate = self;
        _codeView.secureType = ChangeTelType;
    }
    return _codeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
}

#pragma mark - SettingPasswordDelegate
- (void)clickTimeBtn:(PassWordView *)pwView {
    
}

- (void)clickSureBtn:(PassWordView *)pwView withInfo:(NSDictionary *)infoDic {
    // 点击下一步
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

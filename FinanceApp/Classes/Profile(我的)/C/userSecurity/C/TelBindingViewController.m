//
//  TelBindingViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/21.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "TelBindingViewController.h"
#import "LoginView.h"
#import "VaildationCodeHelper.h"

@interface TelBindingViewController ()<LoginViewDelegate>

@property (nonatomic, strong) LoginView *bindView;

@property (nonatomic, strong) VaildationCodeHelper *helper;
@end

@implementation TelBindingViewController

- (VaildationCodeHelper *)helper {
    if (!_helper) {
        _helper = [[VaildationCodeHelper alloc] init];
        
    }
    return _helper;
}

- (LoginView *)bindView {
    if (!_bindView) {
        _bindView = [[LoginView alloc] init];
        _bindView.backgroundColor = k_white_color;
        _bindView.type = BindingType;
        _bindView.delegate = self;
    }
    return _bindView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    
    self.view.backgroundColor = k_back_color;
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.bindView];
}

- (void)addMasnory {
    [_bindView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(5));
        make.left.right.bottom.offset(0);
    }];
}

// 获取验证码
- (void)clickTimeBtnClickWith:(NSString *)telStr {
    [self.helper helperGetValidationCodeCallback:^(id obj, NSError *error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"短信发送成功"];
        }
    } telStr:telStr];
}

// 点击绑定按钮
- (void)clickLoginBtnClickWith:(LoginView *)loginView withInfo:(NSDictionary *)postInfo {
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:postInfo];
    [muDic addEntriesFromDictionary:@{@"session_id": kApplicationDelegate.userHelper.userInfo.token}];
    [kUserInfoHelper loginButtonWithUserInfo:muDic callback:^(id obj, NSError *error) {
        if ([obj[@"status"] integerValue] == 100) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
            //
            [MJYUtils saveToUserDefaultWithKey:user_telephoneBinding withValue:postInfo[@"phone"]];
        } else {
            [SVProgressHUD showErrorWithStatus:obj[@"msg"]];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  QuickLoginViewController.m
//  FinaceApp
//
//  Created by SX on 2018/3/6.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "QuickLoginViewController.h"
#import "LoginView.h"
#import "LoginViewController.h"

#import "WXApiManager.h"
#import "WXApiRequestHandler.h"
#import "UIAlertView+WX.h"
#import "VaildationCodeHelper.h"

@interface QuickLoginViewController()<LoginViewDelegate, WXApiManagerDelegate>
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) UILabel *bottomLb;
@property (nonatomic, strong) UIImageView *wechatImg;

@property (nonatomic, strong) VaildationCodeHelper *helper;

@property (nonatomic, strong) WXApiManager *wxManage;

@end

@implementation QuickLoginViewController

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
        _loginView.backgroundColor = k_white_color;
        _loginView.delegate = self;
        _loginView.type = LoginType;
    }
    return _loginView;
}

- (VaildationCodeHelper *)helper {
    if (!_helper) {
        _helper = [[VaildationCodeHelper alloc] init];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷登录";
    self.view.backgroundColor = k_back_color;
    
    // 创建单例
    [WXApiManager sharedManager].delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_back"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)initUI {
    [super initUI];
    [self.view addSubview:self.loginView];
}

- (void)addMasnory {
    [_loginView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(5));
        make.left.right.bottom.offset(0);
    }];
}

#pragma mark - LoginViewDelegate
- (void)clickTimeBtnClickWith:(NSString *)telStr {
    [self.helper helperGetValidationCodeCallback:^(id obj, NSError *error) {
        if (!error) {
            
        }
    } telStr:telStr];
}

- (void)clickGoLoginPageClick {
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (void)clickLoginBtnClickWith:(LoginView *)loginView withInfo:(NSDictionary *)postInfo {
    
    [kUserInfoHelper loginButtonWithUserInfo:postInfo callback:^(id obj, NSError *error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSuccessNotification object:nil];
        }
        
    }];
}

- (void)clickChatImgClickWith:(LoginView *)loginView {
    if ([WXApi isWXAppInstalled]) { // 判断是否应用程序安装了微信
        [WXApiRequestHandler sendAuthRequestScope:kAuthScope State:kAuthState OpenID:kAuthOpenID InViewController:self];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:actionConfirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 成功登录回调
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    
    [UIAlertView showWithTitle:strTitle message:strMsg sure:nil];
}

@end

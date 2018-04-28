//
//  TelBindingViewController.m
//  FinanceApp
//
//  Created by SX on 2018/4/21.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "TelBindingViewController.h"
#import "LoginView.h"

@interface TelBindingViewController ()<LoginViewDelegate>

@property (nonatomic, strong) LoginView *bindView;

@end

@implementation TelBindingViewController

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
- (void)clickTimeBtnClickWith:(LoginView *)loginView {
    
}

// 点击绑定按钮
- (void)clickLoginBtnClickWith:(LoginView *)loginView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

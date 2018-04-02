//
//  ForgetViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/12.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ForgetViewController.h"
#import "RegisterView.h"

@interface ForgetViewController ()<RegisterDelegate>

@property (nonatomic, strong) RegisterView *registerView;

@end

@implementation ForgetViewController

- (RegisterView *)registerView {
    if (!_registerView) {
        _registerView = [[RegisterView alloc] initWithTypeView:ForgetType];
        _registerView.delegate = self;
        _registerView.backgroundColor = k_white_color;
    }
    return _registerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    self.view.backgroundColor = k_white_color;
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.registerView];
    [self addMasnory];
}

- (void)addMasnory {
    [_registerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

#pragma mark - delegate
- (void)clickSureBtn:(RegisterView *)registerView withInfo:(NSDictionary *)infoDic{
    
}

- (void)clickTimeBtn:(RegisterView *)registerView {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

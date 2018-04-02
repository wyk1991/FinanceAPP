//
//  RegisterViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

@interface RegisterViewController ()<RegisterDelegate>

@property (nonatomic, strong) RegisterView *registerView;

@end

@implementation RegisterViewController

- (RegisterView *)registerView {
    if (!_registerView) {
        _registerView = [[RegisterView alloc] initWithTypeView:RegisterType];
        _registerView.backgroundColor = k_white_color;
        _registerView.delegate = self;
    }
    return _registerView;
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
- (void)clickSureBtn:(RegisterView *)registerView withInfo:(NSDictionary *)infoDic {
    
}

- (void)clickTimeBtn:(RegisterView *)registerView {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = k_white_color;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end

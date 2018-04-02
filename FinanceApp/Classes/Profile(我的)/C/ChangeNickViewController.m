//
//  ChangeNickViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ChangeNickViewController.h"

@interface ChangeNickViewController ()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UITextField *nickTf;

@end

@implementation ChangeNickViewController

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = k_white_color;
        
    }
    return _backView;
}

- (UITextField *)nickTf {
    if (!_nickTf) {
        _nickTf = [[UITextField alloc] init];
        _nickTf.backgroundColor = k_white_color;
        _nickTf.text = self.content;
        _nickTf.font = k_text_font_args(CalculateHeight(14));
        _nickTf.delegate = self;
        _nickTf.tintColor = k_black_color;
        _nickTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _nickTf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改昵称";
    self.view.backgroundColor = k_back_color;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(changeNicknameButtonAction)];
}

- (void)initUI {
    [super initUI];
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.nickTf];
    
    [self addMasnory];
}

- (void)addMasnory {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(20));
        make.left.right.offset(0);
        make.height.mas_equalTo(CalculateHeight(44));
    }];
    [_nickTf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(CalculateWidth(15));
        make.right.equalTo(_backView.mas_right).offset(0);
        make.top.offset(CalculateHeight(5));
        make.bottom.offset(-CalculateHeight(5));
    }];
}

- (void)changeNicknameButtonAction {
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

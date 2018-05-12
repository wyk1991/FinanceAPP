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
    
    self.view.backgroundColor = k_back_color;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(changeNicknameButtonAction)];
    [self.nickTf becomeFirstResponder];
}

- (void)initUI {
    [super initUI];
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.nickTf];
    
    [self addMasnory];
}

- (void)addMasnory {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(15/2));
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
    if (!self.nickTf.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请填写用户名称"];
        return;
    }
    [HttpTool afnNetworkPostParameter:@{@"nickname": self.nickTf.text, @"session_id":kApplicationDelegate.userHelper.userInfo.token} toPath:modify_user success:^(id result) {
        if ([result[@"status"] integerValue] == 100) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            kApplicationDelegate.userHelper.userInfo.user.nickname = self.nickTf.text;
            NSData *modelData = [kNSUserDefaults valueForKey:kAppHasCompletedLoginUserInfo];
            UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
            model.user.nickname = self.nickTf.text;
            [kNSUserDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } orFail:^(NSError *error) {
        [LDToast showToastWith:@"修改失败，查看网络问题"];
        
    }];
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

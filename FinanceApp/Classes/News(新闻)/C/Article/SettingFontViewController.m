//
//  SettingFontViewController.m
//  FinanceApp
//
//  Created by wangyangke on 2018/5/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SettingFontViewController.h"

#define kSettingWidth (kScreenWidth - CalculateWidth(150) - CalculateWidth(20)*4)/3

@interface SettingFontViewController ()
@property (nonatomic, strong) UIView  *backView;
@property (nonatomic, strong) UILabel *tipLb;
@property (nonatomic, strong) UIButton *smallBtn;
@property (nonatomic, strong) UIButton *middleBtn;
@property (nonatomic, strong) UIButton *maxBtn;
@end

@implementation SettingFontViewController
- (UIView *)backView {
    if (!_backView) {
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.layer.cornerRadius = 10.0f;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UILabel *)tipLb {
    if (_tipLb) {
        _tipLb = [[UILabel alloc] initWithText:@"" textColor:k_white_color textFont:k_text_font_args(17) textAlignment:1];
    }
    return _tipLb;
}

- (void)initUI {
    [super initUI];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.tipLb];
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CalculateWidth(20)*(i+1) + i*kSettingWidth, CGRectGetMaxY(self.tipLb.frame) + CalculateHeight(20), kSettingWidth, CalculateHeight(20));
        btn.layer.cornerRadius = 3.f;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        [btn setTitle:SettingFontArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:k_white_color forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(k_loginmain_color)] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)([UIColor clearColor])] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(clickSettingFont:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backView addSubview:btn];
        
    }
    
    [self addMasnory];
}

- (void)addMasnory {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(150));
        make.left.offset(CalculateWidth(75));
        make.right.offset(-CalculateWidth(75));
        make.size.height.mas_equalTo(CalculateHeight(180));
    }];
    [_tipLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(20));
        make.centerX.offset(0);
    }];
}

- (void)clickSettingFont:(UIButton *)sender {
    for (UIButton *btn in self.backView.subviews) {
        if (sender == btn) {
            [sender setSelected:YES];
        } else {
            [sender setSelected:NO];
        }
    }
    if (self.fontBlock) {
        self.fontBlock(sender.tag);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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

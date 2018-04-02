//
//  OboutUsViewController.m
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "OboutUsViewController.h"

@interface OboutUsViewController ()

@property (nonatomic, strong) UIImageView *companyLogo;

@property (nonatomic, strong) UILabel *content1;
@property (nonatomic, strong) UILabel *content2;
@property (nonatomic, strong) UILabel *content3;

@property (nonatomic, strong) UILabel *versionLb;

@end

@implementation OboutUsViewController

- (UIImageView *)companyLogo {
    if (!_companyLogo) {
        _companyLogo = [[UIImageView alloc] init];
        _companyLogo.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _companyLogo;
}

- (UILabel *)content1 {
    if (!_content1) {
        _content1 = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:1];
    }
    return _content1;
}

- (UILabel *)content2 {
    if (!_content2) {
        _content2 = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(CalculateHeight(14)) textAlignment:1];
    }
    return _content2;
}

- (UILabel *)content3 {
    if (!_content3) {
        _content3 = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:1];
    }
    return _content3;
}

- (UILabel *)versionLb {
    if (!_versionLb) {
        _versionLb = [[UILabel alloc] initWithText:@"" textColor:k_black_color textFont:k_text_font_args(14) textAlignment:1];
    }
    return _versionLb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.companyLogo];
    [self.view addSubview:self.content1];
    [self.view addSubview:self.content2];
    [self.view addSubview:self.content3];
    
    [self.view addSubview:self.versionLb];
    [self addMasnory];
}

- (void)addMasnory {
    [_companyLogo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CalculateHeight(60));
        make.centerX.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(90)));
    }];
    
    [_content1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_companyLogo.mas_bottom).offset(CalculateHeight(40));
        make.centerX.offset(0);
        make.size.mas_equalTo(CGSizeMake(CalculateWidth(200), CalculateHeight(15)));
    }];
    
    [_content2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content1.mas_bottom).offset(CalculateWidth(5));
        make.centerX.offset(0);
        make.size.equalTo(_content1);
    }];
    
    [_content3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content2.mas_bottom).offset(CalculateHeight(5));
        make.centerX.offset(0);
        make.size.equalTo(_content1);
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

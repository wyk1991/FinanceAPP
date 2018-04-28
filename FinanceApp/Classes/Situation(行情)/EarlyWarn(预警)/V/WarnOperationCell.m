//
//  WarnOperationCell.m
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "WarnOperationCell.h"
#import "ChartsDetailModel.h"

@interface WarnOperationCell()<UITextFieldDelegate>

@end

@implementation WarnOperationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.cnyBtn setImage:[UIImage imageNamed:@"warning_price"] forState:UIControlStateNormal];
    [self.cnyBtn setImage:[UIImage imageNamed:@"warning_price_ed"] forState:UIControlStateSelected];
    
    [self.usdBtn setImage:[UIImage imageNamed:@"warning_price"] forState:UIControlStateNormal];
    [self.usdBtn setImage:[UIImage imageNamed:@"warning_price_ed"] forState:UIControlStateSelected];
    
    [self.cnyBtn setSelected:YES];
    [self.usdBtn setSelected:NO];

    self.maxPriceTf.delegate =self;
    self.minPriceTf.delegate = self;
    
    [self.maxPriceTf addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.minPriceTf addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
}
- (IBAction)maxPriceClick:(id)sender {
    if ([self.cnyBtn isSelected] && [self.maxPriceTf.text integerValue] < [self.model.price_cny integerValue]) {
        [SVProgressHUD showWithStatus:@"上涨价格必须大于当前价格"];
        return;
    }
    if ([self.usdBtn isSelected] && [self.minPriceTf.text integerValue] < [self.model.price_usd integerValue]) {
        [SVProgressHUD showWithStatus:@"上涨价格必须大于当前价格"];
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(addWarnPriceWith:currencyType:didClickWithContent:)]) {
        [_delegate addWarnPriceWith:@"max" currencyType:[self.usdBtn isSelected] ? @"usd": @"cny" didClickWithContent:self.maxPriceTf.text];
    }
    
}

- (IBAction)minPriceClick:(id)sender {
    if ([self.cnyBtn isSelected] && [self.maxPriceTf.text integerValue] > [self.model.price_cny integerValue]) {
        [SVProgressHUD showWithStatus:@"下跌价格必须小于当前价格"];
        return;
    }
    if ([self.usdBtn isSelected] && [self.minPriceTf.text integerValue] > [self.model.price_usd integerValue]) {
        [SVProgressHUD showWithStatus:@"下跌价格必须小于当前价格"];
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(addWarnPriceWith:currencyType:didClickWithContent:)]) {
        [_delegate addWarnPriceWith:@"min" currencyType:[self.usdBtn isSelected] ? @"usd": @"cny" didClickWithContent:self.minPriceTf.text];
    }
}

- (IBAction)cnyBtnClick:(id)sender {
//    if ([sender isSelected]) {
//        [sender setImage:[UIImage imageNamed:@"warning_price_ed"] forState:UIControlStateNormal];
//    } else {
//        [self.usdBtn setImage:[UIImage imageNamed:@"warning_price"] forState:UIControlStateNormal];
//    }
        [self.usdBtn setSelected: NO];
        [sender setSelected:YES];
    self.maxPriceTf.placeholder = @"￥ 价格";
    self.minPriceTf.placeholder = @"￥ 价格";
}

- (IBAction)usdBtnClick:(UIButton *)sender {
        [self.cnyBtn setSelected: NO];
        [sender setSelected:YES];
    self.maxPriceTf.placeholder = @"$ 价格";
    self.minPriceTf.placeholder = @"$ 价格";
    
//    if ([sender isSelected]) {
//        [sender setImage:[UIImage imageNamed:@"warning_price_ed"] forState:UIControlStateNormal];
//    } else {
//        [self.cnyBtn setImage:[UIImage imageNamed:@"warning_price"] forState:UIControlStateNormal];
//    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}


- (void)textValueChanged:(UITextField *)tf {
    if (tf == self.maxPriceTf && tf.text.length != 0) {
        [self.maxBtn setImage:[UIImage imageNamed:@"wraning_add_ed"] forState:UIControlStateNormal];
    } else {
        [self.maxBtn setImage:[UIImage imageNamed:@"wraning_add"] forState:UIControlStateNormal];
    }
    if (tf == self.minPriceTf && tf.text.length != 0) {
        [self.minBtn setImage:[UIImage imageNamed:@"wraning_add_ed"] forState:UIControlStateNormal];
    } else {
        [self.minBtn setImage:[UIImage imageNamed:@"wraning_add"] forState:UIControlStateNormal];
    }
}



@end

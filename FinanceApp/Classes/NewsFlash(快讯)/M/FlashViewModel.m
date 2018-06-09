//
//  FlashViewModel.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "FlashViewModel.h"
#import "FlashModel.h"

@implementation FlashViewModel

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setModel:(FlashModel *)model {
    _model = model;
    
    CGFloat contentX = CalculateWidth(12);
    CGFloat contentY = CalculateHeight(36);
    CGSize contentSize = [self sizeWithText:model.desc font:k_text_font_args(CalculateHeight(17)) maxSize:CGSizeMake(kScreenWidth - CalculateWidth(24)*2, MAXFLOAT)];
    _contentF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    if (model.ico_card) {
        _lineF = CGRectMake(contentX + CalculateWidth(5), 0, CalculateWidth(0.5), _contentF.size.height + CalculateHeight(80)*2);
        _detailF = CGRectMake(contentX, CGRectGetMaxY(_contentF) + CalculateHeight(20), kScreenWidth - CalculateWidth(24)*2, CalculateHeight(80));
        _cellHeight = CGRectGetMaxY(_detailF)+ CalculateHeight(70);
    } else {
        _lineF = CGRectMake(contentX + CalculateWidth(5), 0, CalculateWidth(0.5), _contentF.size.height + CalculateHeight(80));
        _detailF = CGRectZero;
        _cellHeight = CGRectGetMaxY(_contentF)+CalculateHeight(70);
    }
    
    
    
}



@end

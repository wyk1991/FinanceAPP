//
//  UILabel+Init.m
//  UTask
//
//  Created by 徐洋 on 2016/12/9.
//  Copyright © 2016年 GXPTW. All rights reserved.
//

#import "UILabel+Init.h"
#import <objc/runtime.h>

@implementation UILabel (Init)

- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                    textFont:(UIFont *)textFont
               textAlignment:(NSTextAlignment)textAlignment
{
    if (self = [super init]) {
        self.text = text;
        self.textColor = textColor;
        self.font = textFont;
        self.textAlignment = textAlignment;
    }
    return self;
}
- (instancetype)initWithText:(NSString *)text
{
    return [self initWithText:text textColor:k_black_color textFont:k_text_font_args(14) textAlignment:0];
}

- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
{
    return [self initWithText:text textColor:textColor textFont:k_text_font_args(14) textAlignment:0];
}
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                    textFont:(UIFont *)textFont
{
    return [self initWithText:text textColor:textColor textFont:textFont textAlignment:0];
}



/**
 *  为某一范围文字添加颜色属性
 *
 *  @param color 文字颜色
 *  @param range 文字范围
 */
- (void)setAttributedLabelTextColor:(UIColor *)color with:(NSRange)range
{
    [self setAttributedLabelTextColorAndRange:@{[self RangeConversionString:range]:color}];
}
/**
 *  为多个范围文字添加不同颜色属性
 *
 *  @param dic @{@"4-5":[UIColor redColor]};
 *              key = 范围   value = 颜色
 */
- (void)setAttributedLabelTextColorAndRange:(NSDictionary *)dic
{
    NSMutableAttributedString *str = self.attributedText.mutableCopy;
    for (NSString *key in dic) {
        NSAssert([[dic objectForKey:key] isKindOfClass:[UIColor class]], @"Color format is not correct");
        NSArray *array = [key componentsSeparatedByString:@"-"];
        if (array.count == 1) {
            NSAssert(NO, @"Range format is not correct");
        }
        NSRange range = {[[array firstObject] integerValue], [[array lastObject] integerValue]};
        UIColor *color = [dic objectForKey:key];
        if ([self searchRange:range andText:self.text]) {
            [str addAttribute: NSForegroundColorAttributeName value:color range:range];
        }else{
            NSAssert(NO, @"Range beyond the length of the label text");
        }
    }
    self.attributedText = str;
}


- (BOOL)searchRange:(NSRange)range andText:(NSString *)text
{
    if (range.length + range.location > text.length) {
        return NO;
    }else{
        return YES;
    }
}
- (NSString *)RangeConversionString:(NSRange)range
{
    return [NSString stringWithFormat:@"%lu-%lu", (unsigned long)range.location, (unsigned long)range.length];
}

@end

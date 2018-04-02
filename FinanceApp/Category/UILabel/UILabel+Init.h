//
//  UILabel+Init.h
//  UTask
//
//  Created by 徐洋 on 2016/12/9.
//  Copyright © 2016年 GXPTW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Init)

/**
 *  初始化方法
 */
- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor;
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                    textFont:(UIFont *)textFont;
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                    textFont:(UIFont *)textFont
               textAlignment:(NSTextAlignment)textAlignment;

- (void)setAttributedLabelTextColor:(UIColor *)color with:(NSRange)range;

@end

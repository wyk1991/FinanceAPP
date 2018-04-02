//
//  UIColor+Hex.h
//  string
//
//  Created by 徐洋 on 16/5/1.
//  Copyright © 2016年 徐洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 *  16进制转换RGB alpha为默认1.0f
 *
 *  @param color 16进制字符串
 *  支持
 *  0Xfffff
 *  #ffffff
 *  ffffff
 *  三种格式字符串
 *  @return 颜色
 */
+ (UIColor *)colorWithHex:(NSString *)color;
/**
 *  16进制转换RGB alpha自定义
 *
 *  @param color 16进制字符串
 *  支持
 *  0Xfffff
 *  #ffffff
 *  ffffff
 *  三种格式字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha;

@end

//
//  UIColor+Hex.m
//  string
//
//  Created by 徐洋 on 16/5/1.
//  Copyright © 2016年 徐洋. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSString *)color
{
    return [self colorWithHex:color alpha:1.0];
}
+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha
{
    NSString *colorString = color;
    unsigned int red, green, blue;
    if (colorString.length >= 6 && colorString.length <=  8) {
        if ([colorString hasPrefix:@"0X"]) {
            colorString = [colorString substringFromIndex:2];
        }else if ([colorString hasPrefix:@"#"]) {
            colorString = [colorString substringFromIndex:1];
        }
        if (![self checkInputVerifyHexadecimal:colorString]) return [UIColor whiteColor];
        NSString *redString = [colorString substringWithRange:NSMakeRange(0, 2)];
        [[NSScanner scannerWithString:redString] scanHexInt:&red];
        NSString *greenString = [colorString substringWithRange:NSMakeRange(2, 2)];
        [[NSScanner scannerWithString:greenString] scanHexInt:&green];
        NSString *blueString = [colorString substringWithRange:NSMakeRange(4, 2)];
        [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    }else{
        return [UIColor whiteColor];
    }
    
    return [UIColor colorWithRed:(float)red / 255.0f green:(float)green / 255.0f blue:(float)blue / 255.0f alpha:alpha];
}

+ (BOOL)checkInputVerifyHexadecimal:(NSString *)text
{
    NSString *regular = @"^[a-fA-F\\d]{6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [predicate evaluateWithObject:text];
}

@end

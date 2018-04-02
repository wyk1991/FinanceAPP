//
//  NSString+Extension.h
//  Easemob
//
//  Created by nacker on 15/12/22.
//  Copyright © 2015年 帶頭二哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSString *)utf8String:(NSString *)str;

+ (NSString *)transformedValue:(long long)value;

+ (NSString *)base64StringFromText:(NSString *)text;
+ (NSString *)textFromBase64String:(NSString *)base64;


- (BOOL)isChinese;

- (BOOL)isURL;

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

+ (NSString *)timeWithDate:(NSDate *)date;


- (NSString *)pinyin;
- (NSString *)pinyinInitial;

/**
 *  获取字符串的实际宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 实际宽度
 */
- (float)widthWithFont:(UIFont *)font height:(float)height;



/**
 *  正则判断手机号码
 */
- (BOOL)isMobileNum;
@end

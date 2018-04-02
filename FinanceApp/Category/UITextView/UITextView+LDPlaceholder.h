// //  UITextView+LDPlaceholder.h
//  LD
//
//  Created by 徐洋 on 2017/3/4.
//  Copyright © 2017年 Losdeoro24K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LDPlaceholder)

/**
 占位符
 */
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end

//
//  UITextView+LDPlaceholder.m
//  LD
//
//  Created by 徐洋 on 2017/3/4.
//  Copyright © 2017年 Losdeoro24K. All rights reserved.
//

#import "UITextView+LDPlaceholder.h"

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

static void *UITEXTVIEW_PLACEHOLDER_LABEL_KEY = (void *)@"UITEXTVIEW_PLACEHOLDER_LABEL_KEY";
static void *UITEXTVIEW_PLACEHOLDER_KEY = (void *)@"UITEXTVIEW_PLACEHOLDER_KEY";
static void *UITEXTVIEW_PLACEHOLDER_FONT_KEY = (void *)@"UITEXTVIEW_PLACEHOLDER_FONT_KEY";
static void *UITEXTVIEW_PLACEHOLDER_TEXTCOLOR_KEY = (void *)@"UITEXTVIEW_PLACEHOLDER_TEXTCOLOR_KEY";

@implementation UITextView (LDPlaceholder)

- (UILabel *)placeholderLabel
{
    return (UILabel *)objc_getAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_LABEL_KEY);
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    objc_setAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_LABEL_KEY, placeholderLabel, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)placeholder
{
    return (NSString *)objc_getAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_KEY);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    objc_setAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_KEY, placeholder, OBJC_ASSOCIATION_RETAIN);
    [self initPlaceholderLabel];
    self.placeholderLabel.text = placeholder;
}

- (UIFont *)placeholderFont
{
    return (UIFont *)objc_getAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_FONT_KEY);
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    objc_setAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_FONT_KEY, placeholderFont, OBJC_ASSOCIATION_RETAIN);
    [self initPlaceholderLabel];
    self.placeholderLabel.font = self.font = placeholderFont;
}

- (UIColor *)placeholderTextColor
{
    return (UIColor *)objc_getAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_TEXTCOLOR_KEY);
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    objc_setAssociatedObject(self, UITEXTVIEW_PLACEHOLDER_TEXTCOLOR_KEY, placeholderTextColor, OBJC_ASSOCIATION_RETAIN);
    [self initPlaceholderLabel];
    self.placeholderLabel.textColor = placeholderTextColor;
}

- (void)initPlaceholderLabel
{
    if (!self.placeholderLabel) {
        self.placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel.font = k_text_font_args(CalculateHeight(15));
        self.placeholderLabel.numberOfLines = 0;
        self.placeholderLabel.textColor = [UIColor colorWithHex:@"898989"];
        [self addSubview:self.placeholderLabel];
        [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.right.offset(-15);
            make.top.offset(6);
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
}

- (void)textChange
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end

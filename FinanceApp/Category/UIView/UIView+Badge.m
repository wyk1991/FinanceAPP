//
//  UIView+Badge.m
//  UTask
//
//  Created by 徐洋 on 2016/12/22.
//  Copyright © 2016年 GXPTW. All rights reserved.
//

#import "UIView+Badge.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) UILabel *dot;

@end

static void *badgereddot = (void *)@"badgereddot";
static void *badgereddotsize = (void *)@"badgereddotsize";
static void *badgereddotoffsetx = (void *)@"badgereddotoffsetx";
static void *badgereddotoffsety = (void *)@"badgereddotoffsety";

@implementation UIView (Badge)

/**
 show badge dot
 */
- (void)showBadge
{
    [self removeBadge];
    [self addSubview:self.dot];
    [self.dot mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.badgeSize, self.badgeSize));
        make.top.right.offset(0);
    }];
}
- (void)showBadgeWith:(NSUInteger)count
{
    [self removeBadge];
    [self addSubview:self.dot];
    if (count > 99) {
        self.dot.text = @"99+";
    }else{
        self.dot.text = [NSString stringWithFormat:@"%lu", (unsigned long)count];
    }
    [self.dot sizeToFit];
    CGFloat width = self.dot.frame.size.width;
    CGFloat height = self.dot.frame.size.height;
    [self.dot mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-2);
        make.right.offset(width * 0.2f);
        make.size.mas_equalTo(CGSizeMake((width > height ? width : height) + 4, height + 4));
    }];
    self.dot.layer.cornerRadius = (height + 4) / 2.f;
}
/**
 remove badge
 */
- (void)removeBadge
{
    [self.dot removeFromSuperview];
}
#pragma mark lazy loading
/**
 set dot
 */
- (void)setDot:(UILabel *)dot
{
    objc_setAssociatedObject(self, &badgereddot, dot, OBJC_ASSOCIATION_RETAIN);
}
/**
 get dot
 */
- (UILabel *)dot
{
    if (!objc_getAssociatedObject(self, &badgereddot)) {
        self.dot = [[UILabel alloc] init];
        self.dot.backgroundColor = [UIColor redColor];
        self.dot.layer.cornerRadius = self.badgeSize/2.f;
        self.dot.layer.masksToBounds = YES;
        self.dot.textColor = k_white_color;
        self.dot.font = k_text_font_args(11);
        self.dot.textAlignment = 1;
    }
    return objc_getAssociatedObject(self, &badgereddot);
}
/**
 set badgeSize
 */
- (void)setBadgeSize:(CGFloat)badgeSize
{
    self.dot.layer.cornerRadius = badgeSize / 2.f;
    [self.dot mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(badgeSize, badgeSize));
    }];
    objc_setAssociatedObject(self, &badgereddotsize, @(badgeSize), OBJC_ASSOCIATION_ASSIGN);
}
/**
 get badgeSize
 */
- (CGFloat)badgeSize
{
    if (![objc_getAssociatedObject(self, &badgereddotsize) floatValue]) {
        self.badgeSize = 9.f;
    }
    return [objc_getAssociatedObject(self, &badgereddotsize) floatValue];
}
/**
 set offsetX
 */
- (void)setOffsetX:(CGFloat)offsetX
{
    [self.dot mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-offsetX);
    }];
    objc_setAssociatedObject(self, &badgereddotoffsetx, @(offsetX), OBJC_ASSOCIATION_ASSIGN);
}
/**
 get offsetX
 */
- (CGFloat)offsetX
{
    if (![objc_getAssociatedObject(self, &badgereddotoffsetx) floatValue]) {
        self.offsetX = 0.f;
    }
    return [objc_getAssociatedObject(self, &badgereddotoffsetx) floatValue];
}
/**
 set offsetY
 */
- (void)setOffsetY:(CGFloat)offsetY
{
    [self.dot mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(offsetY);
    }];
    objc_setAssociatedObject(self, &badgereddotoffsety, @(offsetY), OBJC_ASSOCIATION_ASSIGN);
}
/**
 get offsetY
 */
- (CGFloat)offsetY
{
    if (![objc_getAssociatedObject(self, &badgereddotoffsety) floatValue]) {
        self.offsetY = 0.f;
    }
    return [objc_getAssociatedObject(self, &badgereddotoffsety) floatValue];
}

@end

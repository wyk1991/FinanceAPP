//
//  UIView+EmptyView.m
//  UTask
//
//  Created by 徐洋 on 2017/2/4.
//  Copyright © 2017年 GXPTW. All rights reserved.
//

#import "UIView+EmptyView.h"
#import <objc/runtime.h>

static void *ldmessagelabel = (void *)@"xzmessagelabel";

@interface UIView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation UIView (EmptyView)

- (void)showEmptyView:(NSString *)str count:(NSInteger)count
{
    if (count != 0) {
        [self.label removeFromSuperview];
    }else{
        [self addSubview:self.label];
        self.label.text = str;
        WS(weakSelf);
        UITableView *tab = (UITableView *)self;
        if (tab.tableHeaderView.frame.size.height > 0) {
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf);
                make.top.offset(20 + tab.tableHeaderView.frame.size.height);
            }];
        }else{
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf);
                make.top.offset(20);
            }];
        }
        self.label.textAlignment = 1;
    }
}
- (void)setLabel:(UILabel *)label
{
    objc_setAssociatedObject(self, &ldmessagelabel, label, OBJC_ASSOCIATION_RETAIN);
}
- (UILabel *)label
{
    if (!objc_getAssociatedObject(self, &ldmessagelabel)) {
        self.label = [UILabel new];
        self.label.font = k_text_font_args(14);
    }
    return objc_getAssociatedObject(self, &ldmessagelabel);
}

@end

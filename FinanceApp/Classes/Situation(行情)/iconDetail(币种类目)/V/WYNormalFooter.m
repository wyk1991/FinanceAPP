//
//  WYNormalFooter.m
//  FinanceApp
//
//  Created by SX on 2018/5/22.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "WYNormalFooter.h"

@implementation WYNormalFooter

#pragma mark - 重写父类的方法
- (void)prepare {
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=20; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //隐藏时间
//self.re.hidden = YES;
    /*隐藏*/
    self.refreshingTitleHidden = YES;
    //隐藏状态
    self.stateLabel.hidden = YES;
}

@end

//
//  SituationHeadView.h
//  FinanceApp
//
//  Created by SX on 2018/3/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

@interface SituationHeadView : BaseView


@property (nonatomic, strong) UIScrollView *topScrollView;

- (instancetype)initWithTopArr:(NSMutableArray *)arr;

@end

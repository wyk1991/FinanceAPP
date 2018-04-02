//
//  BaseView.m
//  SSS_MALL
//
//  Created by 关宇琼 on 2017/8/2.
//  Copyright © 2017年 Losdeoro24K. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = k_white_color;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

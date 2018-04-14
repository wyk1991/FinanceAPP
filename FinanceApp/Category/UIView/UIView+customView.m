//
//  UIView+customView.m
//  doubleTableView
//
//  Created by tarena13 on 15/10/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "UIView+customView.h"
#define LabelWidth (kScreenWidth*11/18)/2
#define LabelHeight CalculateHeight(50)

@implementation UIView (customView)

+ (UIView *)viewWithLabelNumber:(NSInteger)num{
    UIView *view = [[self alloc] initWithFrame:CGRectMake(0, 0, LabelWidth * num, LabelHeight)];
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LabelWidth * i, 0, LabelWidth, LabelHeight)];
        label.tag = i;
        label.font = k_text_font_args(15);
        label.textColor = k_siutaion_coloum;
        label.textAlignment = 1;
        [view addSubview:label];
    }
    return view;
}

@end

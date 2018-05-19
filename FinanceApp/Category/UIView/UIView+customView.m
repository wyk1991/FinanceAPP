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

+ (UIView *)viewWithLabelNumber:(NSInteger)num withCount:(NSInteger)count{
    UIView *view = [[self alloc] initWithFrame:CGRectMake(0, 0, count == 5 ? chartRightLabelWidth*num :  LabelWidth * num, LabelHeight)];
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(count == 5 ?   (i== 0 ? chartRightLabelMargin/2 :(chartRightLabelWidth+chartRightLabelMargin-CalculateWidth(10))*i ): LabelWidth * i, 0, count == 5 ? chartRightLabelWidth : LabelWidth, LabelHeight)];
        label.tag = i;
        label.font = k_text_font_args(15);
        label.textColor = k_siutaion_coloum;
        label.textAlignment = count == 5 ? 0 : 1;
        [view addSubview:label];
    }
    return view;
}

@end

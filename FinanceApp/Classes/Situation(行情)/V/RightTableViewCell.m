//
//  RightTableViewCell.m
//  doubleTableView
//
//  Created by tarena13 on 15/10/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "RightTableViewCell.h"
#import "CoinAllInfoModel.h"
#import "ChartsDetailModel.h"

@implementation RightTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number
{
    static NSString *identifier = @"cell";
    // 1.缓存中取
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
         cell = [[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        UIView *view = [UIView viewWithLabelNumber:number];
        view.tag = 100;
        [cell.contentView addSubview:view];

    }
    return cell;
}

- (void)setModel:(CoinDetailListModel *)model {
    if (_model != model) {
        _model = model;
    }
    NSMutableArray *tmp = @[].mutableCopy;
    [tmp addObject:[NSString stringWithFormat:@"￥%@",model.price]];
    [tmp addObject:[NSString stringWithFormat:@"%@%%",model.oneday_change]];
    [tmp addObject:model.oneday_increase];
    [tmp addObject:model.oneday_money_cny];
    [tmp addObject:model.circulate_money];
    [tmp addObject:model.circulate_amount];
    [tmp addObject:[NSString stringWithFormat:@"%@%%",model.circulate_percentage]];
    [tmp addObject:model.total_amount];
    //这里先使用假数据
    UIView *view = [self viewWithTag:100];
    for (UILabel *label in view.subviews) {
        label.text = nil;

        label.text = tmp[label.tag];
        if (label.tag == 1) {
            NSString *str = tmp[label.tag];
            label.textColor = [str containsString:@"-"] ? k_siutaion_reduce : k_siutaion_increase;
            label.text = [str containsString:@"-"] ? [NSString stringWithFormat:@"%@%%",model.oneday_change]:[NSString stringWithFormat:@"+%@%%",model.oneday_change];
        }
    }
    
}

- (void)setPriceModel:(PricesModel *)priceModel {
    if (_priceModel != priceModel) {
        _priceModel  = priceModel;
    }
    NSMutableArray *tmp = @[].mutableCopy;
    [tmp addObject:[NSString stringWithFormat:@"￥%@ ＄%@",priceModel.price_cny, priceModel.price_usd]];
    [tmp addObject:[NSString stringWithFormat:@"%@%%",priceModel.change]];
    [tmp addObject:priceModel.oneday_amount];
    [tmp addObject:priceModel.oneday_highest_cny];
    [tmp addObject:priceModel.oneday_lowest_cny];
//    [tmp addObject:model.circulate_amount];
//    [tmp addObject:[NSString stringWithFormat:@"%@%%",model.circulate_percentage]];
//    [tmp addObject:model.total_amount];
}

@end

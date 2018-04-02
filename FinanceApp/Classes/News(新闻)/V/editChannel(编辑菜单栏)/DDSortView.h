//
//  DDSortView.h
//  FinanceApp
//
//  Created by SX on 2018/3/22.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

@interface DDSortView : BaseView

/**
 *  已选的数据
 */
@property (nonatomic, strong)NSMutableArray *selectedArray;
/**
 *  可选的数据
 */
@property (nonatomic, strong)NSMutableArray *optionalArray;


@end

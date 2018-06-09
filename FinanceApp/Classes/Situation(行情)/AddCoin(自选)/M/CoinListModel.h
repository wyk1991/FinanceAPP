//
//  CoinListModel.h
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *logo;
// 1 选中状态 0 未选中的状态
@property (nonatomic, copy) NSString *selected;
@end

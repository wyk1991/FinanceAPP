//
//  UpdateCoinListModel.h
//  FinanceApp
//
//  Created by SX on 2018/5/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateCoinListModel : NSObject
@property (nonatomic, strong) NSString *coin_name;
@property (nonatomic, strong) NSMutableArray *markets;
@end

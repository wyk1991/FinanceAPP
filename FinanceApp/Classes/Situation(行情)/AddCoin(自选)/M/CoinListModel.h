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
@property (nonatomic, assign) BOOL isSelect;
@end

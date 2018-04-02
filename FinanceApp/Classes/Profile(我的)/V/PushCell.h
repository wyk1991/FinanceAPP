//
//  PushCell.h
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseCell.h"

@class SettingModel;

@interface PushCell : BaseCell

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) SettingModel *model;
@end

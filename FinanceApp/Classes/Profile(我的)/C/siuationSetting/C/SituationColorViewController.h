//
//  SituationColorViewController.h
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//
typedef enum : NSUInteger {
    settingColorType,
    settingPriceType,
    settingNoticeType,
} SettingType;

#import "BaseViewController.h"


@interface SituationColorViewController : BaseViewController

@property (nonatomic, assign) SettingType *setType;
@end

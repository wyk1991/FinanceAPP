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
    settingPushType,
    settingSecureType
} SettingType;

#import "BaseViewController.h"


@interface BaseSituationListViewController : BaseViewController

@property (nonatomic, assign) SettingType setType;
@end

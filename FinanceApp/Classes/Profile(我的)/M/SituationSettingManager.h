//
//  SituationManager.h
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SituationSettingManager : NSObject

+ (NSMutableArray *)getSettingModelWithType:(NSInteger)type;

+ (NSMutableArray *)getFeedBackModel;

+ (NSString *)settingEarlyWaring;

@end

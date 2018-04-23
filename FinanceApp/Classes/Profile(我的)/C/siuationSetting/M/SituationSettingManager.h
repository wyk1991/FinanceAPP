//
//  SituationManager.h
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SituationSettingManager : NSObject

+ (NSArray *)getSettingModelWithType:(NSInteger)type;

@end

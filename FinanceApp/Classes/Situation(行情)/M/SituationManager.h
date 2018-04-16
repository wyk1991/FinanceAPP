//
//  SituationManager.h
//  FinanceApp
//
//  Created by SX on 2018/4/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SituationManager : NSObject

+ (NSArray *)rightTitleWithType:(NSInteger)showType;

+ (NSArray *)leftTitleWithType:(NSInteger)showType;
@end

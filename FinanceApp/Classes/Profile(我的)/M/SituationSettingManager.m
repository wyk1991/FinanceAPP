//
//  SituationManager.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationSettingManager.h"
#import "SettingModel.h"
#import "FeedBackModel.h"

@implementation SituationSettingManager

+ (NSMutableArray *)getSettingModelWithType:(NSInteger)type {
    NSArray *arr;
    if (type == 0) {
        arr = @[
                @{@"title": @"绿涨红跌", @"isArrow":@"0", @"isSwitch": @"0", @"isSelect": [[kNSUserDefaults valueForKey:user_greenRed] isEqualToString:@"redRise"] ? @"0" : @"1"},
                @{@"title": @"红涨绿跌", @"isArrow": @"0",@"isSwitch":@"0",@"isSelect": [[kNSUserDefaults valueForKey:user_greenRed] isEqualToString:@"redRise"] ? @"1" : @"0"}
                     ];
    } else if (type == 1) {
        arr = @[
                @{@"title": @"CNY多价格", @"isArrow":@"0", @"isSwitch": @"0", @"isSelect": [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? @"1" : @"0"},
                @{@"title":@"USD多价格", @"isArrow":@"0", @"isSwitch": @"0", @"isSelect":[[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"usd"] ? @"1" : @"0"}
                ];
    } else if(type == 2){
        arr = @[
                @{@"title": @"声音", @"isArrow":@"0",@"isSwitch": @"1",  @"isSelect": [[kNSUserDefaults valueForKey:user_noticeVoiceType] isEqualToString:@"1"] ? @"1" : @"0"},
                @{@"title": @"震动", @"isArrow":@"0",@"isSwitch": @"1", @"isSelect": [[kNSUserDefaults valueForKey:user_noticeShackType] isEqualToString:@"1"] ? @"1" : @"0"}
                ];
    } else if(type == 3){
        arr = @[
                @{@"title": @"接受新消息通知", @"isArrow":@"0",@"isSwitch": @"1",  @"isSelect": [[kNSUserDefaults valueForKey:user_pushSwitch] isEqualToString:@"1"] ? @"1" : @"0"}
                ];
    } else if (type == 4) {
        arr = @[
                
                @[@{@"title": @"手机号", @"isArrow": @"1", @"isSwitch": @"0", @"content": [kNSUserDefaults valueForKey:user_telephoneBinding] ? [kNSUserDefaults valueForKey:user_telephoneBinding] : @"未设置"},
                @{@"title": @"微信", @"isArrow": @"0", @"isSwitch": @"1"}],
                
                @[@{@"title": @"账号密码", @"isArrow": @"1", @"isSwitch": @"0", @"content": [kNSUserDefaults valueForKey:user_settingPassword] ? [kNSUserDefaults valueForKey:user_settingPassword] : @"未设置"}]
                ];
    }
    NSMutableArray *modelArr = [SettingModel mj_objectArrayWithKeyValuesArray:arr];
    return modelArr;
}

+ (NSMutableArray *)getFeedBackModel {
    NSArray *arr = @[
                            @{@"title": @"反馈类型", @"placeholder":@"", @"content":@"", @"isTf": @"0", @"isTv": @"0", @"isMoreSel": @"1"},
                            @{@"title": @"反馈内容", @"placeholder":@"请尽量详细描述您的问题,您的建议与反馈是我们\n前进的动力", @"content":@"", @"isTf": @"0", @"isTv": @"1", @"isMoreSel": @"0"},
                            @{@"title": @"联系方式", @"placeholder":@"QQ/微信号/邮箱/手机号", @"content":@"", @"isTf": @"1", @"isTv": @"0", @"isMoreSel": @"0"},
                            ];
    NSMutableArray *modelArr = [FeedBackModel mj_objectArrayWithKeyValuesArray:arr];
    
    return modelArr;
}

+ (NSString *)settingEarlyWaring {
    NSString *muStr= @"";
    if ([[kNSUserDefaults valueForKey:user_noticeShackType] isEqualToString:@"1"]) {
        muStr = @"震动";
    }
    if ([[kNSUserDefaults valueForKey:user_noticeVoiceType] isEqualToString:@"1"]) {
        muStr = @"声音";
    }
    if ([[kNSUserDefaults valueForKey:user_noticeShackType] isEqualToString:@"1"] && [[kNSUserDefaults valueForKey:user_noticeVoiceType] isEqualToString:@"1"]) {
        muStr = @"声音+震动";
    }
    return muStr;
}

@end

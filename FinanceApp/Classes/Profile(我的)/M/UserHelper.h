//
//  UserHelper.h
//  FinanceApp
//
//  Created by SX on 2018/3/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"

@interface UserHelper : BaseViewModel

@property (nonatomic, strong) NSMutableArray *columnList;
@property (nonatomic, strong) NSMutableArray *feedbackList;
+ (instancetype)shareHelper;


- (void)helpGetMyColumnData:(NSString *)path withParms:(NSDictionary *)dic callBack:(UICallback)callback;

- (void)helpPostWithPath:(NSString *)path withInfo:(NSDictionary *)dic callBackBlock:(UICallback)callback;

- (void)helpFeedBackHistoryWithPath:(NSString *)path callBack:(UICallback)callback;

@end

//
//  FlashHelper.h
//  FinanceApp
//
//  Created by SX on 2018/3/30.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"

@interface FlashHelper : BaseViewModel

/** 快讯类别 */
@property (nonatomic, strong) NSMutableArray *flashTag;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, assign) NSInteger page;

 
+ (instancetype)shareHelper;
- (void)helperGetFlashTagWithPath:(NSString *)path callback:(UICallback)callback;
- (void)helperGetFlashListDataWithPath:(NSString *)path withTags:(NSString *)tagStr callback:(UICallback)callback;
@end

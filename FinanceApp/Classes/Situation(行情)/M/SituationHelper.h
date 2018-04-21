//
//  SituationHelper.h
//  FinanceApp
//
//  Created by SX on 2018/4/9.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"

@class CoinAllInfoModel, IconDetailViewController;
@interface SituationHelper : BaseViewModel

/** 获取得到的快讯的标签数据 */
@property (nonatomic, strong) NSMutableArray *tagList;

/** 获取库币汇总信息 */
@property (nonatomic, strong) NSMutableArray *coinInfoData;

/** 库币列表页面 */
@property (nonatomic, strong) NSMutableArray *coinListData;

/** charts图表数组 */
@property (nonatomic, strong) NSMutableArray *chartList;

/** charts图表详情 */
@property (nonatomic, strong) NSMutableArray *oneDayList;

/** 保存列表的数据 */
@property (nonatomic, strong) NSMutableArray *chartCoinList;

/** 图表数据中的最大值和最小值 */


/** 自选的币库列表数据 */
@property (nonatomic, strong) NSMutableArray *optionsCoinList;
/** 保存section的打开的关闭状态 */
@property (nonatomic, strong) NSMutableDictionary *optionOpenDict;

/** 当前页面 */
@property (nonatomic, assign) NSInteger page;

/** coin list data */
@property (nonatomic, strong) NSMutableArray *coinNameList;

+ (instancetype)shareHelper;

- (void)helperGetTagDataWithPath:(NSString *)path callback:(UICallback)callback;

- (void)heplerGetStockCoinInfo:(NSString *)path callBack:(UICallback)callback;

- (void)helperGetListCoinWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback;

- (void)heplerGetCoinDetailWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback;

/** 获取自选列表数据 */
- (void)helperGetCoinListNameDataWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback;

- (void)helperGetOptionCoinListWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback;

- (NSDictionary *)helpGetCoinAllInfoWith:(CoinAllInfoModel *)model;

@end

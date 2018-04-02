//
//  HomeHelper.h
//  FinanceApp
//
//  Created by SX on 2018/3/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsModel.h"

@interface HomeHelper : BaseViewModel

/** 获取头条首页数据 */
@property (nonatomic, strong) NSMutableArray *dateList;

/** 首页tag标签数据 */
@property (nonatomic, strong) NSMutableArray *tagList;
/** 滚动图数据 */
@property (nonatomic, strong) NSMutableArray *scrollList;
/** 获取首页固定头条 */
@property (nonatomic, strong) NSMutableArray *AdModelArr;

/** 记录key和value的种类 */
@property (nonatomic, strong) NSMutableArray *tagArr;
/** 记录sort排序没有选中的种类 */
@property (nonatomic, strong) NSMutableArray *unSelectTagArr;

/** 分页数 */
@property (nonatomic, assign) NSInteger page;

/** 获取滚动内容 */
@property (nonatomic, strong) NSMutableArray *contentArr;



+ (instancetype)shareHelper;

- (void)helperGetTagDataFromPath:(NSString *)path callBack:(UICallback)callback;

- (void)helperGetScrollDataWithPath:(NSString *)path callBack:(UICallback)callback;

- (void)helperGetMiddleData:(NSString *)path callBack:(UICallback)callback;

- (void)helperGetDataListWithPath:(NSString *)path WithTag:(NSString *)tag callBack:(UICallback)callback;

// 获取搜索的热词
- (void)helperGetHotWordsWithPath:(NSString *)path callBack:(UICallback)callback;
// 获取搜索结果
- (void)helperGetSearchArticleWithPath:(NSString *)path params:(NSDictionary *)parms callBack:(UICallback)callback;
@end

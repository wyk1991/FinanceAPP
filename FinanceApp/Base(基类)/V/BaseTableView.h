//
//  BaseTableView.h
//  SXErp
//
//  Created by 关宇琼 on 2017/11/15.
//  Copyright © 2017年 SXJT. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BaseTableView : UITableView
// 无数据占位图点击的回调函数

#pragma clang diagnostic push

#pragma clang diagnostic ignored "-Wstrict-prototypes"

@property (nonatomic,copy) void (^noContentViewTapedBlock) ();

#pragma clang diagnostic pop

/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType;

/* 移除无数据占位图 */
- (void)removeEmptyView;
@property (nonatomic, copy) NSString *op;


@end

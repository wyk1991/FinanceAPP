//
//  NodataView.h
//  SXErp
//
//  Created by 关宇琼 on 2017/11/15.
//  Copyright © 2017年 SXJT. All rights reserved.
//

#import "BaseView.h"
// 无数据占位图的类型
typedef NS_ENUM(NSInteger, NoContentType) {
    /** 无网络 */
    NoContentTypeNetwork = 0,
    /** 无订单 */
    NoContentTypeOrder   = 1,
    /** 无搜索内容 */
    NoContentTypeSearch  = 2,
    /** 无发表文章内容信息 */
    NoContentTypeArticle = 3
    
};

@interface NodataView : BaseView

/** 无数据占位图的类型 */
@property (nonatomic,assign) NoContentType type;

@property (nonatomic, strong) NSString *searchContent;
@end

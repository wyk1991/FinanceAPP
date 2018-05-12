//
//  BaseTableView.m
//  SXErp
//
//  Created by 关宇琼 on 2017/11/15.
//  Copyright © 2017年 SXJT. All rights reserved.
//

#import "BaseTableView.h"
#import "NodataView.h"

@interface BaseTableView (){
    NodataView *_noContentView;
}


@end

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
#ifdef __IPHONE_11_0
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
    }
    return self;
}





/**
展示无数据占位图

@param emptyViewType 无数据占位图的类型
*/
- (void)showEmptyViewWithType:(NSInteger)emptyViewType{
    
    // 如果已经展示无数据占位图，先移除
    if (_noContentView) {
        [_noContentView removeFromSuperview];
        _noContentView = nil;
    }
    
    //------- 再创建 -------//
    _noContentView = [[NodataView alloc] init];
    [self addSubview:_noContentView];
    [_noContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight - 64));
    }];
    
    //------- 添加单击手势 -------//
    [_noContentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noContentViewDidTaped:)]];
}

/* 移除无数据占位图 */
- (void)removeEmptyView{
    [_noContentView removeFromSuperview];
    _noContentView = nil;
}

// 无数据占位图点击
- (void)noContentViewDidTaped:(NodataView *)noContentView{
    if (self.noContentViewTapedBlock)
    {
        self.noContentViewTapedBlock(); // 调用回调函数
    }
}



@end

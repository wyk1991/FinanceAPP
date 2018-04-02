//
//  StorageHeaderView.h
//  FinanceApp
//
//  Created by SX on 2018/3/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

@protocol  SearchTextClick <NSObject>

- (void)clickSearchTextWithIconType:(NSString *)searchTpye;
@end

@interface StorageHeaderView : BaseView

@property (nonatomic, weak) id<SearchTextClick> delegate;

@end

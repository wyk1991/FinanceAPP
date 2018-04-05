//
//  NewFlashListCell.h
//  FinanceApp
//
//  Created by wangyangke on 2018/3/31.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseCell.h"
#import "FlashViewModel.h"

@class NewFlashListCell;
@protocol ShareBtnClickDelegate<NSObject>

- (void)shareBtnClick:(NewFlashListCell *)cell;

@end

@interface NewFlashListCell : BaseCell

@property (nonatomic, weak) id<ShareBtnClickDelegate> delegate;
@property (nonatomic, strong) FlashViewModel *viewModel;
@end

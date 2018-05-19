//
//  ShareBottomView.h
//  FinanceApp
//
//  Created by SX on 2018/5/16.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

@class ShareBottomView;
@protocol  ShareBtnClickDelegate <NSObject>

- (void)clickTheBottomView:(ShareBottomView *)view withTag:(NSInteger)tag;

@end

@interface ShareBottomView : BaseView
@property (nonatomic, weak) id<ShareBtnClickDelegate> delegate;
@end

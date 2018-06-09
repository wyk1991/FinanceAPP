//
//  SettingFontViewController.h
//  FinanceApp
//
//  Created by wangyangke on 2018/5/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

typedef void(^ClickFontSize)(NSInteger index);

@interface SettingFontViewController : BaseView

@property (nonatomic, copy) ClickFontSize fontBlock;

- (void)show;
@end

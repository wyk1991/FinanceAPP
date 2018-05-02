//
//  SettingFontViewController.h
//  FinanceApp
//
//  Created by wangyangke on 2018/5/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ClickFontSize)(NSInteger index);

@interface SettingFontViewController : BaseViewController

@property (nonatomic, copy) ClickFontSize fontBlock;

@end

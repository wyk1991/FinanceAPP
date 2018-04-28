//
//  VaildationCodeHelper.h
//  FinanceApp
//
//  Created by SX on 2018/4/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"

@interface VaildationCodeHelper : BaseViewModel

- (void)helperGetValidationCodeCallback:(UICallback)callBack telStr:(NSString *)str;

- (void)helperPostInfo:(NSDictionary *)inParam callback:(UICallback)callBack;
@end

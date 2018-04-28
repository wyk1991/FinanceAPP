//
//  PassWordView.h
//  FinanceApp
//
//  Created by SX on 2018/4/26.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

typedef enum : NSUInteger {
    ChangeTelType,
    ChangePasswordType,
    
} SecureType;

@class PassWordView;
@protocol  SettingPasswordDelegate <NSObject>
- (void)clickSureBtn:(PassWordView *)pwView withInfo:(NSDictionary *)infoDic;

- (void)clickTimeBtn:(PassWordView *)pwView;

@end

@interface PassWordView : BaseView
@property (nonatomic, weak) id<SettingPasswordDelegate> delegate;
@property (nonatomic, assign) SecureType secureType;
@end

//
//  RegisterView.h
//  FinanceApp
//
//  Created by SX on 2018/3/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

typedef enum : NSUInteger {
    ForgetType,
    RegisterType,
} LoginViewType;

@class RegisterView;

@protocol  RegisterDelegate <NSObject>

-(void)clickSureBtn:(RegisterView *)registerView withInfo:(NSDictionary *)infoDic;

- (void)clickTimeBtn:(RegisterView *)registerView withTel:(NSString *)telStr ;
@end

@interface RegisterView : BaseView

@property (nonatomic, weak) id<RegisterDelegate> delegate;

@property (nonatomic, assign) LoginViewType type;

- (instancetype)initWithTypeView:(LoginViewType)type;

@end

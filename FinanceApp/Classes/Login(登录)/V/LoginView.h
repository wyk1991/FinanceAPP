//
//  LoginView.h
//  FinaceApp
//
//  Created by SX on 2018/3/6.
//  Copyright © 2018年 王杨柯. All rights reserved.
//

#import "BaseView.h"



@class LoginView;

@protocol  LoginViewDelegate <NSObject>

- (void)clickTimeBtnClickWith:(LoginView *)loginView;

- (void)clickLoginBtnClickWith:(LoginView *)loginView;

- (void)clickGoLoginPageClick;

- (void)clickChatImgClickWith:(LoginView *)loginView;

@end

@interface LoginView : BaseView
@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end

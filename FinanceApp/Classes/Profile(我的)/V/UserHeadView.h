//
//  UserHeadView.h
//  FinaceApp
//
//  Created by SX on 2018/3/5.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "BaseView.h"

@class UserHeadView;
@protocol  UserHeaderDelegate <NSObject>

- (void)userHeader:(UserHeadView *)headerView didClickWithUserInfo:(NSDictionary *)userInfo;

@end

@interface UserHeadView : BaseView


@property (nonatomic, weak) id<UserHeaderDelegate> delegate;

@end

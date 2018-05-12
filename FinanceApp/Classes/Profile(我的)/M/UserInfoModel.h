//
//  UserInfoModel.h
//  FinanceApp
//
//  Created by SX on 2018/3/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface UserInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) User *user;

-(instancetype)initWithToke:(NSString *)token user:(User *)user;

@end

@interface User : NSObject<NSCoding>

@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *nickname;
@end

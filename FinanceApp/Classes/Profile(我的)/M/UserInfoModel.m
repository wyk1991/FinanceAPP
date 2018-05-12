//
//  UserInfoModel.m
//  FinanceApp
//
//  Created by SX on 2018/3/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"token": @"session_id"
             };
}

- (instancetype)initWithToke:(NSString *)token user:(User *)user {
    if (self = [super init]) {
        self.token = token;
        self.user = user;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.user forKey:@"user"];
}

@end


@implementation User

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.avatar_url = [aDecoder decodeObjectForKey:@"avatar_url"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.avatar_url forKey:@"avatar_url"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}

@end

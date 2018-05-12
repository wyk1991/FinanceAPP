//
//  FeedBackListModel.h
//  FinanceApp
//
//  Created by SX on 2018/5/10.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackListModel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *create_time;
@end

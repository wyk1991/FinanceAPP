//
//  FeedBackModel.h
//  FinanceApp
//
//  Created by SX on 2018/4/17.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *isTf;
@property (nonatomic, copy) NSString *isTv;
@property (nonatomic, copy) NSString *isMoreSel;

@end

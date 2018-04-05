//
//  FlashModel.h
//  FinanceApp
//
//  Created by wangyangke on 2018/4/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseView.h"

//"hottness": 5,
//"description": "韩国交易所Upbit",
//"duration": 12,
//"remain_coin": 1000,
//"coin_total": 90000,
//"ico_card": {
//    "coin_name": "TokenPay",
//    "icon_url": "http://118.31.43.148/resources/ico/Actus-Logo-150x150.jpg",
//    "end_time": "2018-09-20T00:00:00Z",
//    "total_amount": 20000000,
//    "sale_amount": 6000000,
//    "rating": "A+"
//},
//"publishedAt": "2018-03-15T07:13:55Z"
@class CardModel;
@interface FlashModel : NSObject


@property (nonatomic, copy) NSString *hottness;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *remain_coin;
@property (nonatomic, copy) NSString *coin_total;
@property (nonatomic, copy) NSString *publishedAt;

//@property (nonatomic, assign, readonly) CGRect cardF;
//@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) CardModel *ico_card;
@end

@interface CardModel: NSObject

@property (nonatomic, copy) NSString *coin_name;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *total_amount;
@property (nonatomic, copy) NSString *sale_amount;
@property (nonatomic, copy) NSString *percentage;
@property (nonatomic, copy) NSString *rating;


@end

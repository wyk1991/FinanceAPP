//
//  RollModel.h
//  FinanceApp
//
//  Created by SX on 2018/3/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RollModel : NSObject
//"title": "新加坡中央银行确认将区块链技术用于跨境支付业务的计划",
//"description": "",
//"url": "https://www.ccn.com/japan-to-urge-g20-nations-to-prevent-cryptocurrencys-use-in-money-laundering/",
//"urlToImage": "https://www.ccn.com/wp-content/uploads/2018/03/G20-flag.jpg",
//"publishedAt": "2018-03-15T08:32:48Z"
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlToImage;
@property (nonatomic, copy) NSString *publishedAt;

@end

//
//  MiddleADModel.h
//  FinanceApp
//
//  Created by SX on 2018/3/19.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *urlToImage;
@property (nonatomic, strong) NSString *publishedAt;
@end

//
//  FlashViewModel.h
//  FinanceApp
//
//  Created by wangyangke on 2018/4/1.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlashModel;
@interface FlashViewModel : NSObject

@property (nonatomic, strong) FlashModel *model;


+ (instancetype)viewModelWithModel:(FlashModel *)model;

//@property (nonatomic, assign) CGRect cycleF;
//@property (nonatomic, assign) CGRect timeF;
//@property (nonatomic, assign) CGRect startF;
@property (nonatomic, assign) CGRect lineF;
@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect detailF;
@property (nonatomic, assign) CGRect bottomF;

//@property (nonatomic, assign) CGRect iconF;
//@property (nonatomic, assign) CGRect titleF;
//@property (nonatomic, assign) CGRect total_amountF;
//@property (nonatomic, assign) CGRect sale_amountF;
//@property (nonatomic, assign) CGRect ratingF;

@property (nonatomic, assign) CGFloat cellHeight;


@end
